//
//  CompanyListWorker.swift
//  MediquoApp
//
//  Created by Guillem Espejo on 05/11/2020.
//
//  This file was generated by the Guillem Espejo Clean Swift Xcode Templates
//

import UIKit

class CompanyListWorker{
    
    var dataStore : CompanyStoreAPI
    
    init(dataStore: CompanyStoreAPI = CompanyStoreSync() ){
        self.dataStore = dataStore
    }
    
    func loadBaseNetworkData(completion: @escaping (Result<[Network],Error>) -> Void){
        self.dataStore.getBaseNetworks(completion: completion)
    }
}