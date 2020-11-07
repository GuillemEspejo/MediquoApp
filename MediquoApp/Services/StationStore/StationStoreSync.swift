//
//  StationStoreSync.swift
//  MediquoApp
//
//  Created by Guillem Espejo on 05/11/2020.
//

import Foundation
import Alamofire
import GECoreDataManager
import CoreData
import PromiseKit

// Special implementation of StationStoreAPI. This implementation combines network connections via alamofire and
// local storage via Core Data syncing the data, hence the name.
class StationStoreSync : StationStoreAPI {    
    
    let coreDataStack = CoreDataManager.shared

    // ------------------------------------------------------------
    // API METHODS
    // ------------------------------------------------------------
    // MARK: - API Methods
    
    // Gets a list of Station elements, representing the information of the bycicle parking
    // stations associated with a particular Network
    func getStations(from network : Network ,completion: @escaping (Swift.Result<[Station],Error>) -> Void ){
        let finalURLString = String(format: Constants.APIEndPoints.Stations , network.href)
        
        guard let url = URL(string: finalURLString) else{
            completion( .failure(MediquoError.wrongEndpoint) )
            return
        }
        
        // The algorithm goes this way:
        // - Launches a server request and tries to parse the response
        // - We delete the old data
        // - Then we save to local storage the new information and send it back to the worker
        // - If the last three steps fail somehow, we automatically access local storage to retrieve cached info
        // - If everything fails, we show an error
        firstly{
            self.launchRequestAndParse(url: url)
            
        }.get{ stations in //We use get as a 'passthrough' step, we don't care of the return type
            _ = self.deleteStationsFromCoreData(withIdNetworkId: network.id)
            
        }.then { stations in
            self.saveStationsToCoreData(stations: stations, withNetworkId: network.id)
            
        }.recover { _ -> Promise<[Station]> in
            self.getStationFromCoreData(networkId: network.id)
            
        }.done { stations in
            DispatchQueue.main.async {
                completion( .success(stations))
            }
            
        }.catch { error in
            DispatchQueue.main.async {
                completion( .failure(error) )
            }
        }
        
    }
    
    // ------------------------------------------------------------
    // PRIVATE METHODS
    // ------------------------------------------------------------
    // MARK: - Private Methods
    // Executes the remote request and returns the approppriate object parsed.
    private func launchRequestAndParse(url:URL) -> Promise<[Station]>{
        return Promise{ seal in
            
            // Execute network request from background thread
            DispatchQueue.global(qos: .background).async {
                
                AF.request(url, method: .get).responseData{ (response) in
                    switch response.result {
                        case let .success(data):
                            if let parsedData : RootContainer? = JSONResponseParser.parseResponse(from:data) {
                                // Return Station array as the others are just mere containers for JSONDecoder
                                seal.fulfill( parsedData!.network.stations )
                                
                            }else{
                                seal.reject( MediquoError.parseError )
                            }
                        case .failure:
                            seal.reject( MediquoError.networkError )
                    }
                }
                
            }
                       
        }
        
    }
    
    // Saves an array of 'Station' to Core Data managed equivalent and returns the data down the PromiseKit chain
    private func saveStationsToCoreData(stations: [Station], withNetworkId networkIdentifier: String) -> Promise<[Station]>{
        return Promise{ seal in
           
            // Get the required ManagedNetwork
            guard let managedNetwork = self.getNetworkFromCoreData(withId: networkIdentifier) else{
                seal.reject(MediquoError.coreDataStackError)
                return
            }

            // Define the creation block
            let createBlock = { (context:NSManagedObjectContext) in
                // We obtain the current context version of the managed object. Otherwise this will crash!
                let currentNetwork = context.object(with: managedNetwork.objectID) as! ManagedNetwork

                for station in stations{
                    let managedStation =  ManagedStation(context: context)
                    managedStation.fromStation(station)
                    currentNetwork.addToStations(managedStation)
                    managedStation.network = currentNetwork
                }
            }
            
            let completion = { (result : Swift.Result<Void,Error>) in
                switch result{
                    case .success:
                        seal.fulfill( stations )
                    case .failure(let error):
                        seal.reject( error )
                }
                
            }
            
            self.coreDataStack.createObjectAsync(using: createBlock, completion: completion)
  
        }

    }
    
    private func getNetworkFromCoreData(withId identifier:String) -> ManagedNetwork?{
        let networkRequest = NSFetchRequest<ManagedNetwork>(entityName: Constants.CoreData.NetworkEntity)
        networkRequest.predicate = NSPredicate(format: Constants.CoreData.NetworkFilterById, identifier)
        
        let fetchResult = coreDataStack.fetchObject(using: networkRequest)
        switch fetchResult {
            case .success(let objects):
                return objects.first
            
            case .failure(let error):
                print(error.localizedDescription)
                return nil
        }
    }
    
    
    // Retrieves the managed version of an array of 'Station' objects from Core Data filtering by network ID
    private func getStationFromCoreData(networkId: String) -> Promise<[Station]>{
        return Promise{ seal in
            let stationRequest = NSFetchRequest<ManagedStation>(entityName: Constants.CoreData.StationEntity)
            stationRequest.predicate = NSPredicate(format: Constants.CoreData.StationFilterByNetworkId, networkId)
            
            self.coreDataStack.fetchObjectAsync(using: stationRequest) { (result) in
                switch result {
                    case .success(let objects):
                        let casted = objects.map { (managed) -> Station in
                            managed.toStation()
                        }
                        seal.fulfill( casted )
                    
                    case .failure(let error):
                        print(error.localizedDescription)
                        seal.reject(error)
                }
            }

        }
        
    }
    
    // Deletes the Core Data managed version of 'Station' objects assigned to a particular Network
    private func deleteStationsFromCoreData(withIdNetworkId identifier:String) -> Promise<Void>{
        return Promise{ seal in
            
            let deleteRequest = NSFetchRequest<ManagedStation>(entityName: Constants.CoreData.StationEntity)
            deleteRequest.predicate = NSPredicate(format: Constants.CoreData.StationFilterByNetworkId, identifier)
            
            coreDataStack.deleteObjectAsync(from: deleteRequest) { (result) in
                switch result {
                    case .success:
                        seal.fulfill( () )
                    
                    case .failure(let error):
                        print(error.localizedDescription)
                        seal.reject(error)
                }
            }
            
        }

    }
    
}
