//
//  ManagedLocation+CoreDataClass.swift
//  MediquoApp
//
//  Created by Guillem Espejo on 06/11/2020.
//
//

import Foundation
import CoreData

@objc(ManagedLocation)
public class ManagedLocation: NSManagedObject {
    
    // This methods allow an easier conversion between the managedobject and its non-managed counterpart
    // and viceversa
    func fromLocation(_ location: Location){
        city = location.city
        country = location.country
        latitude = location.latitude
        longitude = location.longitude
    }
    
    func toLocation() -> Location{
        let locCity = city ?? ""
        let locCountry = country ?? ""
        
        return Location(city: locCity, country: locCountry, latitude: latitude, longitude: longitude)
    }

}
