//
//  CompanyStoreAPI.swift
//  MediquoApp
//
//  Created by Guillem Espejo on 05/11/2020.
//

import Foundation

// Company Store API. The class implementing this protocol must give access to all the information related to bycicle networks and
// the companies that operates them
protocol CompanyStoreAPI {
    func getBaseNetworks(completion: @escaping (Result<[Network],Error>) -> Void )    
}
