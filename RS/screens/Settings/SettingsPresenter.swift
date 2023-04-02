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
    var timerColor: Color
    var timerMinutes: Int
    var timerSingleColor: Bool
    var autoRelaunch: Bool
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
    }
    
  
    func refresh(){
        self.storage.saveAppPreferences(model: model)
        let data = prepareModels(preferences: storage.getAppPreferences())
        self.view.reloadData(models: data)
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
            SettingsSwichCellModel(
                title: Translations.Settings.soundEnable,
                enable: preferences.isEnabledSound,
                callback: { [weak self] in
                    self?.view.didSwichChanged()
                    self?.model.isEnabledSound = $0
            }),
            SettingsVolumeCellModel(
                title: Translations.Settings.soundVolume,
                volume: preferences.volume,
                callback: { [weak self] in
                    self?.model.volume = $0
            }),
            SettingsHeaderCellModel(
                title: Translations.Settings.timerLabel
            ),
            SettingsTimerMinutesCellModel(
                title: Translations.Settings.timerMaxLabel,
                minutes: preferences.timerMinutes,
                callback: { [weak self] in
                    self?.model.timerMinutes = Int($0)
                }
            ),
            SettingsSwichCellModel(
                title: Translations.Settings.timerAutoReload,
                enable: preferences.autoRelaunch,
                callback: { [weak self] in
                    self?.view.didSwichChanged()
                    self?.model.autoRelaunch = $0
            }),
            SettingsSwichCellModel(
                title: Translations.Settings.singleProgressColor,
                enable: preferences.timerSingleColor,
                callback: { [weak self] in
                    self?.view.didSwichChanged()
                    self?.model.timerSingleColor = $0
            }),
            SettingsColorCellModel(
                title: Translations.Settings.timerLabel,
                currentColor: preferences.timerColor.uiColor,
                callback: { [weak self] in
                    self?.view.didColorSelectorTap()
                    self?.view.startSelectColorAlert(
                        title: $0,
                        currentColor: $1,
                        callback: { [weak self] in
                            self?.model.timerColor = $0
                            self?.refresh()
                        })
            }),
            SettingsHeaderCellModel(
                title: Translations.Settings.yesNoSectors
            ),
            SettingsSteppperCellModel(
                title: Translations.Settings.count,
                value: preferences.yesNoCount,
                maxValue: 20.0,
                minValue: 10.0,
                callback: { [weak self] in
                    self?.model.yesNoCount = $0
            }),
            SettingsColorCellModel(
                title: Translations.SelectColor.yes,
                currentColor: preferences.yesColor.uiColor,
                callback: { [weak self] in
                    self?.view.didColorSelectorTap()
                    self?.view.startSelectColorAlert(
                        title: $0,
                        currentColor: $1,
                        callback: { [weak self] in
                            self?.model.yesColor = $0
                            self?.refresh()
                        })
            }),
            SettingsColorCellModel(
                title: Translations.SelectColor.no,
                currentColor: preferences.noColor.uiColor,
                callback: { [weak self] in
                    self?.view.didColorSelectorTap()
                    self?.view.startSelectColorAlert(
                        title: $0,
                        currentColor: $1,
                        callback: { [weak self] in
                            self?.model.noColor = $0
                            self?.refresh()
                        })
            }),
            SettingsHeaderCellModel(
                title: Translations.Import.label
            ),
            SettingsSimpleCellModel(
                title: Translations.Import.buttonLabel,
                callback: { [weak self] in
                    self?.view.navigateToImport()
            }),
            SettingsHeaderCellModel(
                title: Translations.Menu.itemTest
            ),
            SettingsSimpleCellModel(
                title: Translations.Settings.startDebug,
                callback: { [weak self] in
                    self?.view.navigateToDebug()
            }),
            SettingsHeaderCellModel(
                title: Translations.Menu.itemCreate
            ),
            SettingsSimpleCellModel(
                title: Translations.Menu.itemCreate,
                callback: { [weak self] in
                    self?.view.navigateToCreate()
            }),
        
        ]
    }
    
}
