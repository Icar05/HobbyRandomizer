//
//  SettingsPresenter.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import Foundation

public final class SettingsPresenter {

    
    
    private let storage: UserDefaultStorage
            
    unowned var view: SettingsViewController!
    
    public func set(view: SettingsViewController) {
        self.view = view
    }
    
    init(storage: UserDefaultStorage){
        self.storage = storage
    }
    
    private let data: [SettingsModel] = [
        SettingsHeaderCellModel(title: Translations.Settings.sound),
        SettingsSoundEnableCellModel(title: Translations.Settings.soundEnable, enable: true, callback: {
            print("isEnable: \($0)")
        }),
        SettingsVolumeCellModel(title: Translations.Settings.soundVolume, volume: 20.0, callback: {
            print("volume: \($0)")
        })
    ]
    
  
    
    func viewDidLoad(){
        self.view.registerCells(models: data)
    }
    
}
