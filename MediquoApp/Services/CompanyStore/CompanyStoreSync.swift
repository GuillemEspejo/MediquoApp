//
//  CompanyStoreSync.swift
//  MediquoApp
//
//  Created by Guillem Espejo on 05/11/2020.
//

import Foundation
import Alamofire
import GECoreDataManager
import CoreData
import PromiseKit

// Special implementation of CompanyStoreAPI. This implementation combines network connections via alamofire and
// local storage via Core Data syncing the data, hence the name.
class CompanyStoreSync : CompanyStoreAPI {
    
    let coreDataStack = CoreDataManager.shared
    var stackInited = false

    // ------------------------------------------------------------
    // API METHODS
    // ------------------------------------------------------------
    // MARK: - API Methods
    
    // Gets a list of Network elements, representing the base information of a bycicle network and the companies that operate it
    func getBaseNetworks(completion: @escaping (Swift.Result<[Network],Error>) -> Void ){ //Swift.Result avoids crashes with PromiseKit.Result

        guard let url = URL(string: Constants.APIEndPoints.Networks) else{
            completion( .failure(MediquoError.wrongEndpoint) )
            return
        }
        
        // The algorithm goes this way:
        // - Initiates local storage
        // - Launches a server request and tries to parse the response
        // - Then we save to local storage the new information and send it back to the worker
        // - If the last two steps fail somehow, we automatically access local storage to retrieve cached info
        // - If everything fails, we show an error
        firstly {
            self.initCoreData()
            
        }.then{
            self.launchRequestAndParse(url: url)
            
        }.then { networks in
            self.saveToCoreData(networks: networks)
            
        }.recover { _ -> Promise<[Network]> in
            self.getNetworksFromCoreData()
            
        }.done { networks in
            DispatchQueue.main.async {
                completion( .success(networks))
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
    private func launchRequestAndParse(url:URL) -> Promise<[Network]>{
        return Promise{ seal in
            
            // Execute network request from background thread
            DispatchQueue.global(qos: .background).async {
                
                AF.request(url, method: .get).responseData{ (response) in
                    switch response.result {
                        case let .success(data):
                            if let parsedData : Root? = JSONResponseParser.parseResponse(from:data) {
                                seal.fulfill( parsedData!.networks )
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
    
    // Inits private Core Data stack used in this app. This is the only initing point for Core Data in the app.
    // If the features change, maybe this must be extracted to another method/class to become safer to call and inject.
    private func initCoreData() -> Promise<Void>{
        return Promise{ seal in
            guard !self.stackInited else{
                seal.fulfill( () )
                return
            }
            
            self.coreDataStack.setup(withModel: Constants.CoreData.ModelName, completion: { [weak self] (result) in
                switch result{
                    case .success:
                        self?.stackInited = true
                        seal.fulfill( () )
                        
                    case .failure(let error):
                        seal.reject(error)
                }
                
            })

        }
        
    }
    
    // Saves an array of 'Network' to Core Data managed equivalent and returns the data down the PromiseKit chain
    private func saveToCoreData(networks:[Network]) -> Promise<[Network]>{
        return Promise{ seal in
            
            let createBlock = { (context:NSManagedObjectContext) in
                for network in networks{
                    
                    let managedNetwork =  ManagedNetwork(context: context)
                    managedNetwork.fromNetwork(network)
                    
                    let location = ManagedLocation(context: context)
                    location.fromLocation(network.location)
                    
                    managedNetwork.location = location // Set relationship
                }
            }
            
            let completion = { (result : Swift.Result<Void,Error>) in
                switch result{
                    case .success:
                        seal.fulfill( networks )
                    case .failure(let error):
                        seal.reject( error )
                }
                
            }

            // Not the most efficient way...
            // We delete all data because this is the root of everything
            _ = self.coreDataStack.clearAllData()
            self.coreDataStack.createObjectAsync(using: createBlock, completion:completion )
            
        }
    }
    
    // Retrieves the managed version of an array of 'Network' objects from Core Data
    private func getNetworksFromCoreData() -> Promise<[Network]>{
        return Promise{ seal in
            
            guard self.stackInited else{
                seal.reject( MediquoError.coreDataStackError )
                return
            }
            
            let networkRequest = NSFetchRequest<ManagedNetwork>(entityName: Constants.CoreData.NetworkEntity)
            self.coreDataStack.fetchObjectAsync(using: networkRequest) { (result) in
                switch result {
                    case .success(let objects):
                        let casted = objects.map { (managed) -> Network in
                            managed.toNetwork()
                        }
                        
                        if casted.count > 0 {
                            seal.fulfill( casted )
                        // If we reach this point, it means there is no internet and the saved data is empty
                        }else{
                            seal.reject( MediquoError.networkError )
                        }
                    
                    case .failure(let error):
                        seal.reject( error )
                }
            }
        }
    }
    
}
