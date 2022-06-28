//
//  SettingsHeaderCellModel.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import Foundation

struct SettingsHeaderCellModel: SettingsModel{


    
    let title: String
    
    func isHeader() -> Bool {
        return true
    }
    
    func getTitle() -> String {
        return self.title
    }
        
    var reuseIdentifier: String = String(describing: SettingsHeaderCell.self)
}
