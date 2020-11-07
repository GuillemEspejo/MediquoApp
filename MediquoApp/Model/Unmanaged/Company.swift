//
//  Company.swift
//  MediquoApp
//
//  Created by Guillem Espejo on 06/11/2020.
//

import Foundation

// According to documentation this should be a String, but server returns sometimes an array,
// sometimes a string and sometimes NULL. Whatever...
enum Company: Codable {
    case string(String)
    case stringArray([String])
    case null
    
    init(fromString composedString : String){
        var fullNameArr = composedString.components(separatedBy: Constants.CoreData.CompanyStringSeparator)
        fullNameArr.removeLast()
        
        switch fullNameArr.count{
            case 0:
                self = .null
                
            case 1:
                self = .string(fullNameArr[0])
                
            default:
                self = .stringArray(fullNameArr)
        }
        
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Company.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Company"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
            case .string(let x):
                try container.encode(x)
                
            case .stringArray(let x):
                try container.encode(x)
                
            case .null:
                try container.encodeNil()
        }
    }
    
    func getValues() -> [String]{
        switch self {
            case .string(let x):
                return [x]

            case .stringArray(let x):
                return x
                
            case .null:
                return [""]
        }
    }
    
    // Used with Core Data as a simpler saving mecanism for String Array
    func getValuesAsSingleString() -> String{
        let values = getValues()
        var singleValue = ""
        for value in values{
            singleValue.append(value)
            singleValue.append(Constants.CoreData.CompanyStringSeparator)
        }
        return singleValue
    }

}
