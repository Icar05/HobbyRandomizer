//
//  SettingsYesNoColorsModel.swift
//  RS
//
//  Created by ICoon on 29.06.2022.
//

import Foundation

struct SettingsYesNoColorsModel: SettingsModel{
    
    let title: String
    
    var yesColor: UIColor
        
    var noColor: UIColor
    
    var callback: () -> Void
    
    
    func isHeader() -> Bool {
        return false
    }
    
    func getTitle() -> String {
        return title
    }
        
    var reuseIdentifier: String = String(describing: SettingsYesNoColors.self)

}
