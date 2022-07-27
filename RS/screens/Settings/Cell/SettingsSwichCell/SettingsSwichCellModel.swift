//
//  SettingsSoundEnableCellModel.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import Foundation

struct SettingsSwichCellModel: SettingsModel{
   
    
    
    
    let title: String
    
    let enable: Bool
    
    let callback: (_ value: Bool) -> Void
    
    
    func isHeader() -> Bool {
        return false
    }
    
    func getTitle() -> String {
        return title
    }
        
    var reuseIdentifier: String = String(describing: SettingsSwichCell.self)

}
