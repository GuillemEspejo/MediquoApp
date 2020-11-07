//
//  StationCell.swift
//  MediquoApp
//
//  Created by Guillem Espejo on 05/11/2020.
//

import Foundation
import UIKit

// StationCell is used to show each of Bycicle parking stations associated with a network
class StationCell: UITableViewCell {
    
    // ------------------------------------------------------------
    // IBOUTLETS
    // ------------------------------------------------------------
    // MARK: - IBOutlets
    @IBOutlet private weak var labelName: UILabel!
    @IBOutlet private weak var labelFreeSlots: UILabel!
    @IBOutlet private weak var labelFreeBikes: UILabel!
    
    @IBOutlet private weak var labelTimeStamp: UILabel!
    @IBOutlet private weak var labelCoordinates: UILabel!


    
    // ------------------------------------------------------------
    // AWAKEFROMNIB
    // ------------------------------------------------------------
    // MARK: - AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // ------------------------------------------------------------
    // CELL CONFIGURATION
    // ------------------------------------------------------------
    // MARK: - Cell Configuration
    func configStationCell(name:String?, freeBikes:Int, freeSlots:Int, updatedTime:String?, location: String?){
        self.labelName.text = name
        self.labelFreeSlots.text = String(freeSlots)
        self.labelFreeBikes.text = String(freeBikes)
        
        self.labelTimeStamp.text = updatedTime
        self.labelCoordinates.text = location
       
    }
}

