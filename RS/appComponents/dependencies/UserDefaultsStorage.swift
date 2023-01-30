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
    func saveTime(model: ElapsedTimeModel) -> Bool{
        do {
            let data = try encoder.encode(model)
            UserDefaults.standard.set(data, forKey: UserDefaultConstants.time)
            return true
        } catch {
            print("Unable to Encode ElapsedTimeModel (\(error))")
            return false
        }
    }
    
    func getTime() -> ElapsedTimeModel{
        if let data = UserDefaults.standard.data(forKey: UserDefaultConstants.time) {
            do {
                return try decoder.decode(ElapsedTimeModel.self, from: data)
            } catch {
                print("Unable to Decode ElapsedTimeModel (\(error))")
                return getDefaultElapsedTimeModel()
            }
        }
        return getDefaultElapsedTimeModel()
    }
    
    @discardableResult
    func clearTime() -> Bool {
         return saveTime(model: getDefaultElapsedTimeModel())
    }
    
    private func getDefaultElapsedTimeModel() -> ElapsedTimeModel{
        return ElapsedTimeModel(startTime: -1, maxTime: -1)
    }
    
    /**
     random models
     */
    func removeAlldData() -> Bool {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        return  UserDefaults.standard.synchronize()
    }
    
    func appendModels(newModels: [ActionModel]) -> Bool{
        var models = getModels() ?? []
            models.append(contentsOf: newModels)
        return self.saveModels(models: models)
    }
    
    @discardableResult
    func saveModels(models: [ActionModel]) -> Bool{
        do {
            let data = try encoder.encode(models)
            UserDefaults.standard.set(data, forKey: UserDefaultConstants.models)
            return true
        } catch {
            print("Unable to Encode Array of Models (\(error))")
            return false
        }
    }
    
    func getModels() -> [ActionModel]?{
        if let data = UserDefaults.standard.data(forKey: UserDefaultConstants.models) {
            do {
                return try decoder.decode([ActionModel].self, from: data)
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
                print("Unable to Decode AppPrefferencesModel (\(error))")
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
            print("Unable to Encode AppPrefferencesModel (\(error))")
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
            timerColor: Color.init(uiColor: UIColor.colorMain!),
            timerMinutes: 15,
            timerSingleColor: true,
            autoRelaunch: true
        )
    }
    
}
