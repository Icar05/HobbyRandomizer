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
    let content: [InfoModelDetail]
}

struct DisplayInfoContentModel{
    let title: String
    let isCathegory: Bool
}

struct DisplayInfoModel{
    let title: String
    let content: [DisplayInfoContentModel]
}

extension InfoModel {
    func toDisplayInfoModel() -> DisplayInfoModel{
        
        let title = self.title
        var content: [DisplayInfoContentModel] = []
        
        self.content.forEach{
            let model = DisplayInfoContentModel(
                title: $0.title,
                isCathegory: true
            )
            
            content.append(model)
            $0.content.forEach{
                let model = DisplayInfoContentModel(
                    title: $0,
                    isCathegory: false
                )
                content.append(model)
            }
        }
        
        return DisplayInfoModel(title: title, content: content)
        
    }
}

class InfoParser: Parser{
    
    func parseData(input: String) -> [InfoModel] {
        
        var models: [InfoModel] = []
        
        input.split(separator: "➦").tail.forEach{
            
            let infoTitle = String($0.split(separator: "➫")[0])
                .trimmingCharacters(in: .whitespacesAndNewlines)
            
            var infoContent: [InfoModelDetail] = []
            
            $0.split(separator: "➫").tail.forEach{
                
                let content = $0.split(separator: "°")
                let title = content[0].trimmingCharacters(in: .whitespacesAndNewlines)
                let children = content.tail.map{String($0)
                    .trimmingCharacters(in: .whitespacesAndNewlines)}
                
                let innerModel = InfoModelDetail(
                    title: title,
                    content: children
                )
                infoContent.append(innerModel)
                
            }
            
            let model = InfoModel(
                title: infoTitle,
                content: infoContent)
                    
            models.append(model)
            
            
        }
        
        return models
    }
    
    func isAppropriatedParcer(key: String)  -> Bool{
        return key == "InfoWithEnumeration"
    }
    
    
}
