//
//  Network.swift
//  MediquoApp
//
//  Created by Guillem Espejo on 06/11/2020.
//

import Foundation

// Based on data created using https://app.quicktype.io/
// Used as a simple Container for the array of Network. Used for automatic JSONDecoder.
struct Root: Codable {
    let networks: [Network]
}

struct Network: Codable {
    let company: Company
    let href, id: String
    let location: Location
    let name: String

    enum CodingKeys: String, CodingKey {
        case company, href, id, location, name
    }
    
}



