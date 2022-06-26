//
//  MainParser.swift
//  RS
//
//  Created by ICoon on 26.06.2022.
//

import Foundation


/**
 if there is no key - just return string
 otherwise return list approtpirate models
 */
class MainParser{
    
    private let log = "MainParser"
    
    private let parsers: [Parser] = [ActionParser(), InfoParser()]
    
    
    private func searchParcer(key: String) -> Parser?{
        return parsers.first{$0.isAppropriatedParcer(key: key)}
    }
    
    func parseString(input: String) -> Any {
        
        guard let key = input.between("圓", "圓"), let parcer = searchParcer(key: key) else{
            printLog(input: "There is no key!")
            return input
        }
        
        if(parcer is ActionParser){
            return (parcer as! ActionParser).parseData(input: input)
        } else if (parcer is InfoParser){
            let data =   (parcer as! InfoParser).parseData(input: input)
            printLog(input: "InfoParser, data: \(data)")
            return data
        }else{
            printLog(input: "There is no appropriate parcer!")
            return input
        }
    }
    
    
    private func printLog(input: String){
        print("\(log): \(input)")
    }
    
}
