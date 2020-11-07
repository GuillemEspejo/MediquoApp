//
//  MediquoError.swift
//  MediquoApp
//
//  Created by Guillem Espejo on 06/11/2020.
//

import Foundation

// General error class, used in all the DataStores
enum MediquoError : Error{
    case networkError
    case wrongEndpoint
    case parseError
    case coreDataStackError
    
    func isRecoverable() -> Bool {
        var recoverable = false
        switch self {            
            case .networkError:
                recoverable = true
            case .wrongEndpoint:
                recoverable = false
            case .parseError:
                recoverable = true
            case .coreDataStackError:
                recoverable = false
        }
        
        return recoverable
    }

}

extension MediquoError : LocalizedError {

    public var errorDescription: String? {
        switch self {
            
        case .networkError:
            return Resources.Localizable.ErrorNetwork
            
        case .wrongEndpoint:
            return Resources.Localizable.ErrorEndPoint

        case .parseError:
            return Resources.Localizable.ErrorParse
            
        case .coreDataStackError:
            return Resources.Localizable.ErrorCoreData
        }
    }
}
