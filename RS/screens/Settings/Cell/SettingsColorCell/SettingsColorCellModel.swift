//
//  SettingsYesNoColorsModel.swift
//  RS
//
//  Created by ICoon on 29.06.2022.
//

import Foundation

struct SettingsColorCellModel: SettingsModel{
    
    let title: String
    
    var currentColor: UIColor
        
    var callback: ((_ text: String, _ newColor: Color) -> Void)? = nil
    
    
    func isHeader() -> Bool {
        return false
    }
    
    func getTitle() -> String {
        return title
    }
        
    var reuseIdentifier: String = String(describing: SettingsColorCell.self)

}
