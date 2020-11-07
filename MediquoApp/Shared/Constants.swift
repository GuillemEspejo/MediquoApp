//
//  Constants.swift
//  MediquoApp
//
//  Created by Guillem Espejo on 06/11/2020.
//

import Foundation

// Constants file
struct Constants {
    
    private init(){}
    
    struct CoreData {
        private init(){}
        
        static let ModelName = "Mediquo"
        static let NetworkEntity = "ManagedNetwork"
        static let StationEntity = "ManagedStation"
        
        static let CompanyStringSeparator = "##()##"
        static let NetworkFilterById = "identifier == %@"
        static let StationFilterByNetworkId = "network.identifier == %@"        
        
    }
    
    struct ViewId{
        static let StoryboardName = "Main"
        static let CompanyListViewControllerName = "CompanyListViewController"

        static let CompanyCellId = "CompanyCell"
        static let StationCellId = "StationCell"
    }
    
    struct APIEndPoints {
        private init(){}
        
        static let StationFilter = "?fields=stations"
        
        static let BaseURL = "http://api.citybik.es"
        static let Networks = BaseURL + "/v2/networks"
        static let Stations = BaseURL + "%@" + StationFilter
        
    }
    
    
}
