//
//  SettingsTimerMinutesCellModel.swift
//  RS
//
//  Created by ICoon on 01.08.2022.
//

import Foundation

struct SettingsTimerMinutesCellModel: SettingsModel{
 
    
    let title: String
    
    let minutes: Int
    
    let callback: (_ minutes: Int) -> Void
    
    
    func isHeader() -> Bool {
        return false
    }
    
    func getTitle() -> String {
        return title
    }
        
    var reuseIdentifier: String = String(describing: SettingsTimerMinutesCell.self)
}
