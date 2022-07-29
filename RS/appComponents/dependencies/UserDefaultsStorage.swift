//
//  UserDefaultsStorage.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 13.10.2021.
//

import Foundation

struct UserDefaultConstants{
    public static var models = "Models"
    public static var appPreferences = "AppPreferences"
}

class UserDefaultStorage{
    
    
    private let encoder = JSONEncoder()
    
    private let decoder = JSONDecoder()
    
    
    func removeAlldData() -> Bool {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        return  UserDefaults.standard.synchronize()
    }
    
    func appendModels(newModels: [RandItemCellModel]) -> Bool{
        var models = getModels() ?? []
            models.append(contentsOf: newModels)
        self.saveModels(models: models)
        return true
    }
    
    func saveModels(models: [RandItemCellModel]){
        do {
            let data = try encoder.encode(models)
            UserDefaults.standard.set(data, forKey: UserDefaultConstants.models)
        } catch {
            print("Unable to Encode Array of Models (\(error))")
        }
    }
    
    
    func getModels() -> [RandItemCellModel]?{
        if let data = UserDefaults.standard.data(forKey: UserDefaultConstants.models) {
            do {
                return try decoder.decode([RandItemCellModel].self, from: data)
            } catch {
                print("Unable to Decode Models (\(error))")
            }
        }
        
        return nil
    }
    
    func getAppPreferences() -> AppPrefferencesModel{
        if let data = UserDefaults.standard.data(forKey: UserDefaultConstants.appPreferences) {
            do {
                return try decoder.decode(AppPrefferencesModel.self, from: data)
            } catch {
                print("Unable to Decode Models (\(error))")
                return getDefaultAppPrefferences()
            }
        }
        
        return getDefaultAppPrefferences()
    }
    
    func saveAppPreferences(model: AppPrefferencesModel){
        do {
            let data = try encoder.encode(model)
            UserDefaults.standard.set(data, forKey: UserDefaultConstants.appPreferences)
        } catch {
            print("Unable to Encode Array of Models (\(error))")
        }
    }
    
    private func getDefaultAppPrefferences() -> AppPrefferencesModel{
        return AppPrefferencesModel(
            isEnabledSound: true,
            volume: 0.3,
            yesNoCount: 10.0,
            yesColor: Color.init(uiColor: UIColor.red),
            noColor: Color.init(uiColor: UIColor.yellow),
            timerMinutes: 5,
            timerSingleColor: false
        )
    }
    
}