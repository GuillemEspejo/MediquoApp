//
//  UIKit+Localizable.swift
//  MediquoApp
//
//  Created by Guillem Espejo on 05/11/2020.
//

import Foundation
import UIKit

// This class should contain all UIKit extensions and subclasses allowing easier localization
@IBDesignable final class UILocalizedLabel: UILabel {
    
    @IBInspectable var tableName: String? {
        didSet {
            guard let tableName = tableName else { return }
            text = text?.localized(tableName: tableName)
        }
    }
    
}
