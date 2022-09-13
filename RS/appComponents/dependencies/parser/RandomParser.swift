//
//  RandomParser.swift
//  RS
//
//  Created by ICoon on 24.07.2022.
//


import Foundation
import UIKit

/**
 ➫  item ° Description
 */


class RandomParser : Parser{
    
    
    
    func isAppropriatedParcer(key: String) -> Bool {
        return key == "Random"
    }
    
    func parseData(input: String) -> [ActionModel] {
        
        var models: [ActionModel] = []
        
        let items = input.split(separator: "➫").tail
            items.forEach{
                    
            let content = $0.split(separator: "°")
            let model = ActionModel(
                title: content[0].trimmingCharacters(in: .whitespacesAndNewlines),
                subTitle: content[1].trimmingCharacters(in: .whitespacesAndNewlines),
                type: .Random)
                    
                models.append(model)
            }
        
        return models
    }
    
}
