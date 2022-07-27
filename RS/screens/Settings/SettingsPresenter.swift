//
//  SettingsPresenter.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import Foundation

struct AppPrefferencesModel: Codable{
    var isEnabledSound: Bool
    var volume: Float
    var yesNoCount: Double
    var yesColor: Color
    var noColor: Color
}


public final class SettingsPresenter {

    
    private let storage: UserDefaultStorage
            
    unowned var view: SettingsViewController!
    
    private var model: AppPrefferencesModel
    
    
    public func set(view: SettingsViewController) {
        self.view = view
    }
    
    init(storage: UserDefaultStorage){
        self.storage = storage
        self.model = storage.getAppPreferences()
        self.fetchData()
    }
    
    
   
    
    private func fetchData(){
       
    }
  
    
    func fetchFreshData(){
        let data = prepareModels(preferences: storage.getAppPreferences())
        self.view.registerCells(models: data)
    }
    
    func savePreferences(){
        self.storage.saveAppPreferences(model: model)
    }
    
    
    
    private func prepareModels(preferences: AppPrefferencesModel) -> [SettingsModel]{
        self.model = preferences
        return [
            SettingsHeaderCellModel(
                title: Translations.Settings.sound
            ),
            SettingsSoundEnableCellModel(
                title: Translations.Settings.soundEnable,
                enable: preferences.isEnabledSound,
                callback: { [weak self] in
                    self?.model.isEnabledSound = $0
            }),
            SettingsVolumeCellModel(
                title: Translations.Settings.soundVolume,
                volume: preferences.volume,
                callback: { [weak self] in
                    self?.model.volume = $0
            }),
            SettingsHeaderCellModel(
                title: Translations.Settings.yesNoSectors
            ),
            SettingsYesNoCellModel(
                title: Translations.Settings.count,
                value: preferences.yesNoCount,
                callback: { [weak self] in
                    self?.model.yesNoCount = $0
                }),
            SettingsYesNoColorsModel(
                title: Translations.Settings.colors,
                yesColor: preferences.yesColor.uiColor,
                noColor: preferences.noColor.uiColor, callback: { [weak self] in
                    self?.view.navigateToColorSelection()
                }),
            SettingsHeaderCellModel(
                title: Translations.Menu.itemTest
            ),
            SettingsSimpleCellModel(
                title: Translations.Settings.startDebug,
                callback: { [weak self] in
                    self?.view.navigateToDebug()
                })
        
        ]
    }
    
}
