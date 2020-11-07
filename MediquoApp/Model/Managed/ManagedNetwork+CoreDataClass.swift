//
//  ManagedNetwork+CoreDataClass.swift
//  MediquoApp
//
//  Created by Guillem Espejo on 06/11/2020.
//
//

import Foundation
import CoreData

@objc(ManagedNetwork)
public class ManagedNetwork: NSManagedObject {
    
    // This methods allow an easier conversion between the managedobject and its non-managed counterpart
    // and viceversa
    func fromNetwork(_ network: Network){
        identifier = network.id
        endpoint = network.href
        name = network.name
        company = network.company.getValuesAsSingleString()
    }
    
    func toNetwork() -> Network{
        
        let companyString = company ?? ""
        
        let netCompany = Company(fromString:companyString)
        let netLocation = location!.toLocation()
        
        let netEndpoint = endpoint ?? ""
        let netId = identifier ?? ""
        let netName = name ?? ""
        
        return Network(company: netCompany, href: netEndpoint, id: netId, location: netLocation, name: netName)

    }


}
