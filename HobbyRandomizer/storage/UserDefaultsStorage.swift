//
//  UserDefaultsStorage.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 13.10.2021.
//

import Foundation

class UserDefaultStorage{
    
    
    func saveModels(models: [HobbyModel]){
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(models)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "Models")

        } catch {
            print("Unable to Encode Array of Models (\(error))")
        }
    }
    
    
    func getModels() -> [HobbyModel]?{
        if let data = UserDefaults.standard.data(forKey: "Models") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                return try decoder.decode([HobbyModel].self, from: data)

            } catch {
                print("Unable to Decode Models (\(error))")
            }
        }
        
        return nil
    }
    
}
