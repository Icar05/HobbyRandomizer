//
//  InfoParcer.swift
//  RS
//
//  Created by ICoon on 26.06.2022.
//

import Foundation

struct InfoModelDetail{
    let title: String
    let content: [String]
}

struct InfoModel{
    let title: String
    let content: InfoModelDetail
}

class InfoParser: Parser{
    
    func parseData(input: String) -> [InfoModel] {
        
        var models: [InfoModel] = []
        
        input.split(separator: "➦").tail.forEach{
            
            let infoTitle = String($0.split(separator: "➫")[0])
                .trimmingCharacters(in: .whitespacesAndNewlines)
            
            let items = $0.split(separator: "➫").tail
                items.forEach{
                    
                    let content = $0.split(separator: "°")
                    let title = content[0].trimmingCharacters(in: .whitespacesAndNewlines)
                    let innerModel = InfoModelDetail(
                        title: title,
                        content: content.tail.map{String($0)
                            .trimmingCharacters(in: .whitespacesAndNewlines)}
                    )
                    
                    let model = InfoModel(
                        title: infoTitle,
                        content: innerModel)
                    
                    models.append(model)
                }
        }
        
        return models
    }
    
    func isAppropriatedParcer(key: String)  -> Bool{
        return key == "InfoWithEnumeration"
    }
    
    
}
