//
//  ManagedStation+CoreDataClass.swift
//  MediquoApp
//
//  Created by Guillem Espejo on 06/11/2020.
//
//

import Foundation
import CoreData

@objc(ManagedStation)
public class ManagedStation: NSManagedObject {
    
    // This methods allow an easier conversion between the managedobject and its non-managed counterpart
    // and viceversa
    func fromStation(_ station: Station){
        identifier = station.id
        name = station.name
        
        emptySlots = Int64(station.emptySlots)
        freeBikes = Int64(station.freeBikes)
        
        latitude = station.latitude
        longitude = station.longitude
        
        timestamp = station.timestamp
    }
    
    func toStation() -> Station{
        let stationIdentifier = identifier ?? ""
        let stationTimestamp = timestamp ?? ""
        let stationName = name ?? ""
        
        return Station(emptySlots: Int(emptySlots),
                       freeBikes: Int(freeBikes),
                       id: stationIdentifier,
                       latitude: latitude,
                       longitude: longitude,
                       name: stationName,
                       timestamp: stationTimestamp)
    }

}
