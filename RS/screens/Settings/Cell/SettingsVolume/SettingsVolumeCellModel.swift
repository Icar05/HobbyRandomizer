//
//  SettingsVolumeCellModel.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import Foundation

struct SettingsVolumeCellModel: SettingsModel{
 
    
 

    
    let title: String
    
    let volume: Float
    
    let callback: (_ folume: Float) -> Void
    
    
    func isHeader() -> Bool {
        return false
    }
    
    func getTitle() -> String {
        return title
    }
        
    var reuseIdentifier: String = String(describing: SettingsVolumeCell.self)
}
