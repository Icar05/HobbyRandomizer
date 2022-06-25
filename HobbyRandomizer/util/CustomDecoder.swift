//
//  CustomDecoder.swift
//  RS
//
//  Created by ICoon on 25.06.2022.
//

import Foundation


class CustomDecoder{
    
    private var log = "Log"
    
    func decodeString(input: String) -> [RandItemCellModel]?{
        
        var data: [RandItemCellModel] = []
        
        let types: [String] = input.split(separator: "#").map{String($0)}
        for index in  1...types.count - 1{
            
            // block by title
            let blockByType: [String]  = types[index].split(separator: "@").map{ String($0)}
            
            if let type = getType(value: blockByType.first!){
               let values = blockByType.tail
                
                values.forEach{
                    //payload
                    let payload = $0.split(separator: "^").map{String($0)}
                    let model = RandItemCellModel(
                        title: payload[0],
                        subTitle: payload[1],
                        type: type)
                    
                    data.append(model)
                }
            }
        }
        
        return data
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
    
    private func printLog(_ value: String){
        print("\(log): \(value)")
    }
}
