//
//  StationStoreAPI.swift
//  MediquoApp
//
//  Created by Guillem Espejo on 05/11/2020.
//

import Foundation

// Station Store API. The class implementing this protocol must give access to all the information related to bycicle park stations
protocol StationStoreAPI {
    func getStations(from network:Network ,completion: @escaping (Result<[Station],Error>) -> Void )
}
