//
//  SettingsSimpleCellModel.swift
//  RS
//
//  Created by ICoon on 27.07.2022.
//

import Foundation

struct SettingsSimpleCellModel: SettingsModel{
    
    let title: String
    
    var callback: () -> Void
    
    
    func isHeader() -> Bool {
        return false
    }
    
    func getTitle() -> String {
        return title
    }
        
    var reuseIdentifier: String = String(describing: SettingsSimpleCellTableViewCell.self)

}
