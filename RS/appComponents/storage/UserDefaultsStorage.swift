//
//  UserDefaultsStorage.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 13.10.2021.
//

import Foundation

class UserDefaultStorage{
    
    
    func appendModels(newModels: [RandItemCellModel]) -> Bool{
        var models = getModels() ?? []
        models.append(contentsOf: newModels)
        self.saveModels(models: models)
        return true
    }
    
    func saveModels(models: [RandItemCellModel]){
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
    
    
    func getModels() -> [RandItemCellModel]?{
        if let data = UserDefaults.standard.data(forKey: "Models") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                return try decoder.decode([RandItemCellModel].self, from: data)

            } catch {
                print("Unable to Decode Models (\(error))")
            }
        }
        
        return nil
    }
    
}
