//
//  Resources.swift
//  MediquoApp
//
//  Created by Guillem Espejo on 06/11/2020.
//

import Foundation

// Resources file. Any resource callable from code should be defined here
struct Resources {
    private init(){}
    
    struct Localizable {
        private init(){}
        private static let TableName = "Localizable"
        private static func localize( text: String , table: String) -> String{
            return text.localized(tableName:table)
        }

        static let CompanyNullName = localize(text: "CompanyNullName", table: TableName)
        static let CompanyNetworkName = localize(text: "CompanyNetworkName" , table: TableName)
        static let NA = localize(text: "NA" , table: TableName)
        static let NetworkNameFormat = localize(text: "NetworkNameFormat", table: TableName)
        
        static let SearchPlaceholder = localize(text: "SearchPlaceholder", table: TableName)
        static let PullRefresh = localize(text: "PullRefresh", table: TableName)
        static let Loading = localize(text: "Loading", table: TableName)
        static let LocationLabel = localize(text: "LocationLabel", table: TableName)
        static let CoordinatesLabel = localize(text: "CoordinatesLabel", table: TableName)
        static let CoordinatesFormat = localize(text: "CoordinatesFormat", table: TableName)

        static let ErrorTitle = localize(text: "ErrorTitle", table: TableName)
        static let ErrorNetwork = localize(text: "ErrorNetwork", table: TableName)
        static let ErrorEndPoint = localize(text: "ErrorEndPoint", table: TableName)        
        static let ErrorParse = localize(text: "ErrorParse", table: TableName)
        static let ErrorCoreData = localize(text: "ErrorCoreData", table: TableName)
        static let ErrorNoInternet = localize(text: "ErrorNoInternet", table: TableName)
        static let ErrorFatal = localize(text: "ErrorFatal", table: TableName)        
        
        static let Proceed = localize(text: "Proceed", table: TableName)
        static let ContactDeveloper = localize(text: "ContactDeveloper", table: TableName)
        static let LocalData = localize(text: "LocalData", table: TableName)
        
        
        
    }
}
