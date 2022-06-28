//
//  SettingsSoundEnableCellModel.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import Foundation

struct SettingsSoundEnableCellModel: SettingsModel{
   
    
    
    
    let title: String
    
    let enable: Bool
    
    let callback: (_ value: Bool) -> Void
    
    
    func isHeader() -> Bool {
        return false
    }
    
    func getTitle() -> String {
        return title
    }
        
    var reuseIdentifier: String = String(describing: SettingsSoundEnableCell.self)

}
