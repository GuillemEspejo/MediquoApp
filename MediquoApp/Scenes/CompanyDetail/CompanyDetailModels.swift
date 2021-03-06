//
//  CompanyDetailModels.swift
//  MediquoApp
//
//  Created by Guillem Espejo on 05/11/2020.
//
//  This file was generated by the Guillem Espejo Clean Swift Xcode Templates
//

import UIKit

enum CompanyDetail {
	
	// ------------------------------------------------------------
	// DISPLAYABLES
	// ------------------------------------------------------------
	// MARK: - Displayables
    struct DisplayableStation : Hashable{
		var name : String?
        var timestamp : String?
        var coordinates : String?
        var availableBikes : Int
        var emptySlots : Int
        
        let id = UUID() // Avoids crashes when hashing for diffable datasource
	}

	// ------------------------------------------------------------
	// USE CASES
	// ------------------------------------------------------------
	// MARK: - Use cases
    enum LoadCompanyData {
        struct Request {
            
        }
        
        struct Response {
            var network : Network?
            var companyName : String?
        }
        
        struct ViewModel {
            var network : Network?
            var titleName : String?
            var city : String?
            var flag : UIImage?
            var coordinates : String?
        }
    }
    
    enum LoadStationData {
        struct Request {
            
        }
        
        struct Response {
            var stations : [Station]
        }
        
        struct ViewModel {
            var stationList : [DisplayableStation]
        }
    }
}
