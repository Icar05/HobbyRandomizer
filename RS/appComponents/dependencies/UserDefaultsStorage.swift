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
    public static var time = "Time"
}

class UserDefaultStorage{
    
    
    
    private let encoder = JSONEncoder()
    
    private let decoder = JSONDecoder()
    
    
    
    /**
     time
     */
    @discardableResult
    func saveTime(time: Int) -> Bool{
            UserDefaults.standard.set(time, forKey: UserDefaultConstants.time)
            return true
    }
    
    func getTime() -> Int{
        return UserDefaults.standard.integer(forKey: UserDefaultConstants.time)
    }
    
    @discardableResult
    func clearTime() -> Bool {
        UserDefaults.standard.set( -1, forKey: UserDefaultConstants.time)
        return true
    }
    
    /**
     random models
     */
    func removeAlldData() -> Bool {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        return  UserDefaults.standard.synchronize()
    }
    
    func appendModels(newModels: [RandItemCellModel]) -> Bool{
        var models = getModels() ?? []
            models.append(contentsOf: newModels)
        return self.saveModels(models: models)
    }
    
    @discardableResult
    func saveModels(models: [RandItemCellModel]) -> Bool{
        do {
            let data = try encoder.encode(models)
            UserDefaults.standard.set(data, forKey: UserDefaultConstants.models)
            return true
        } catch {
            print("Unable to Encode Array of Models (\(error))")
            return false
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
    
    
    /**
     all application preferences
     */
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
    
    @discardableResult
    func saveAppPreferences(model: AppPrefferencesModel) -> Bool{
        do {
            let data = try encoder.encode(model)
            UserDefaults.standard.set(data, forKey: UserDefaultConstants.appPreferences)
            return true
        } catch {
            print("Unable to Encode Array of Models (\(error))")
            return false
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
            timerSingleColor: false,
            timerOnlyForeground: false
        )
    }
    
}
