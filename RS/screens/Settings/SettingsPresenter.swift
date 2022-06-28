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
}


public final class SettingsPresenter {

    
    
    private var data: [SettingsModel] = []
    
    private let storage: UserDefaultStorage
    
    private var model: AppPrefferencesModel
            
    unowned var view: SettingsViewController!
    
    
    
    public func set(view: SettingsViewController) {
        self.view = view
    }
    
    init(storage: UserDefaultStorage){
        self.storage = storage
        self.model = storage.getAppPreferences()
        self.initData()
    }
    
    
    func initData(){
        self.data =  [
            SettingsHeaderCellModel(
                title: Translations.Settings.sound
            ),
            SettingsSoundEnableCellModel(
                title: Translations.Settings.soundEnable,
                enable: model.isEnabledSound,
                callback: {
                    self.model.isEnabledSound = $0
            }),
            SettingsVolumeCellModel(
                title: Translations.Settings.soundVolume,
                volume: model.volume,
                callback: {
                    self.model.volume = $0
            }),
            SettingsHeaderCellModel(
                title: Translations.Settings.yesNoSectors
            ),
            SettingsYesNoCellModel(
                title: Translations.Settings.count,
                value: model.yesNoCount,
                callback: {
                    self.model.yesNoCount = $0
                })
        
        ]
    }
  
    
    func viewDidLoad(){
        self.view.registerCells(models: data)
    }
    
    func savePreferences(){
        self.storage.saveAppPreferences(model: model)
    }
    
}
