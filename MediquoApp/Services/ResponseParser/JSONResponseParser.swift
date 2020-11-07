//
//  JSONResponseParser.swift
//  MediquoApp
//
//  Created by Guillem Espejo on 06/11/2020.
//

import Foundation

// This class should contain everything related to JSON Response parsing
struct JSONResponseParser{
    
    // Parses a JSON Response based on 'Data' return type. It uses Generics allowing easy reusing.
    static func parseResponse<T:Decodable>(from data: Data) -> T?{
        var parsedResponse : T?
        do{
            parsedResponse = try JSONDecoder().decode(T.self, from: data)
            
        // If error, we want details for easy debugging...
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
            
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("CodingPath:", context.codingPath)
            
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("CodingPath:", context.codingPath)
            
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("CodingPath:", context.codingPath)
            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        return parsedResponse
    }

    
}

