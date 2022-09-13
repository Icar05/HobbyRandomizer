//
//  ActionParser.swift
//  RS
//
//  Created by ICoon on 26.06.2022.
//

import Foundation
import UIKit

/**
 ➦Necessary➦
 ➫  item ° Description
 */


class ActionParser : Parser{
    
    
    
    func isAppropriatedParcer(key: String) -> Bool {
        return key == "Action"
    }
    
    func parseData(input: String) -> [ActionModel] {
        
        var models: [ActionModel] = []
        
        input.split(separator: "➦").tail.forEach{
            
            let subString = $0.split(separator: "➫")[0]
            
            if  let type = getType(value: String(subString).withoutSpecialCharacters){
                let items = $0.split(separator: "➫").tail
                items.forEach{
                    
                    let content = $0.split(separator: "°")
                    let model = ActionModel(
                        title: content[0].trimmingCharacters(in: .whitespacesAndNewlines),
                        subTitle: content[1].trimmingCharacters(in: .whitespacesAndNewlines),
                        type: type)
                    
                    models.append(model)
                }
            }else{
                print("MainParser: \(String($0)) not type")
            }
            
        }
        
        return models
    }
    
    
    private func getType(value: String) -> ItemType?{
        let raw = value.withoutSpecialCharacters
        
        switch raw {
        case "ToDo":
            return .ToDo
        case "HardDayNight":
            return .HardDayNight
        case "HappyWeekend":
            return .HappyWeekend
        default:
            return nil
        }
    }
    
    
    
    
}
