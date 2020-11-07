//
//  Location.swift
//  MediquoApp
//
//  Created by Guillem Espejo on 06/11/2020.
//

import Foundation

struct Location: Codable {
    let city, country: String
    let latitude, longitude: Double
}
