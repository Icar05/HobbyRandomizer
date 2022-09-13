//
//  JsonDecoder.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import Foundation

class JsonDecoder{
    
    
    private let log = "JsonDecoder"
    
    
    func modelToData<T>(model: T) -> Data? where T : Codable{
        do {
            return try JSONEncoder().encode(model)
        } catch let error {
            print("Error encode data:  (\(error))")
            return nil
        }
    }
    
    func decode<T>(data: Data, type: T.Type) -> T? where T: Codable{
        do{
            return  try JSONDecoder().decode(T.self, from: data) as T
        } catch  {
            
            print("error: \(error)")
            return nil
        }
    }
    
    
    private func printLog(_ value: String){
        print("[ \(log) ] : \(value)")
    }
}
