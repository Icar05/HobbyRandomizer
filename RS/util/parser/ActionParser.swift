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
    
    func parseData(input: String) -> [RandItemCellModel] {
        
        var models: [RandItemCellModel] = []
        
        input.split(separator: "➦").tail.forEach{
            
            let subString = $0.split(separator: "➫")[0]
            
            if  let type = getType(value: String(subString).withoutSpecialCharacters){
                let items = $0.split(separator: "➫").tail
                items.forEach{
                    
                    let content = $0.split(separator: "°")
                    let model = RandItemCellModel(
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
        case "Necessary":
            return .necessary
        case "WorkInProgress":
            return .workInProgress
        case "FreeTime":
            return .freetime
        default:
            return nil
        }
    }
    
    
    
    
}
