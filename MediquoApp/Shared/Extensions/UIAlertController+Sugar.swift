//
//  UIAlertController+Sugar.swift
//  MediquoApp
//
//  Created by Guillem Espejo on 06/11/2020.
//

import Foundation
import UIKit

// Syntactic sugar method added to UIAlertController
extension UIAlertController {
    
    static func createWith(_ error:Error) -> UIAlertController{
        
        var message = error.localizedDescription
        
        // In a more complex app, we should route to a new viewcontroller which handles the error appropriately
        if let finalError = error as? MediquoError {
            message.append("\n\n")
            
            if finalError.isRecoverable() {
                message.append(Resources.Localizable.LocalData)
            }else{
                message.append(Resources.Localizable.ContactDeveloper)
            }
        }
            
        var alertController : UIAlertController
        alertController = UIAlertController(title: Resources.Localizable.ErrorTitle ,
                                            message: message,
                                            preferredStyle: .alert)
        
        let proceed = UIAlertAction(title: Resources.Localizable.Proceed,
                                     style: .default, handler: nil)
        alertController.addAction(proceed)
        
        return alertController
        
    }
    
    
}
