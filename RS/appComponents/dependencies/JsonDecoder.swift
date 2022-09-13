//
//  JsonDecoder.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import Foundation

class JsonDecoder{
    
    
    private let log = "JsonDecoder"
    
    
    func decodeData(data: Data) -> [ActionModel]?{
        do {
            return try JSONDecoder().decode([ActionModel].self, from: data)
        } catch let error{
            printLog("Error decode data:  (\(error))")
        }
        return nil
    }
    
    func encodeData(models: [ActionModel]) -> Data?{
        do {
            return try JSONEncoder().encode(models)
        } catch let error {
            printLog("Error encode data:  (\(error))")
        }
        return nil
    }
    
    
    private func printLog(_ value: String){
        print("[ \(log) ] : \(value)")
    }
}
