//
//  SettingsYesNoCellModel.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import Foundation

struct SettingsSteppperCellModel: SettingsModel{
        
        let title: String
        
        var value: Double
    
        var maxValue: Double
    
        var minValue: Double
            
        let callback: (_ value: Double) -> Void
        
        
        func isHeader() -> Bool {
            return false
        }
        
        func getTitle() -> String {
            return title
        }
            
        var reuseIdentifier: String = String(describing: SettingsStepperCell.self)

}
