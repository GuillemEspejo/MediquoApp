//
//  Station.swift
//  MediquoApp
//
//  Created by Guillem Espejo on 05/11/2020.
//

import Foundation

// Added for autodecoding with JSONParser, not really used
struct RootContainer: Codable {
    let network: RootStation
}
// Added for autodecoding with JSONParser, not really used
struct RootStation: Codable {
    let stations: [Station]
}

struct Station: Codable {
    let emptySlots: Int
    let freeBikes: Int
    let id: String
    let latitude, longitude: Double
    let name, timestamp: String

    enum CodingKeys: String, CodingKey {
        case emptySlots = "empty_slots"
        case freeBikes = "free_bikes"
        case id, latitude, longitude, name, timestamp
    }
}
