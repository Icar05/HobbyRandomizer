//
//  YesNoPresenter.swift
//  RS
//
//  Created by ICoon on 30.06.2022.
//

import Foundation

public final class YesNoPresenter{
    
    
    private let storage: UserDefaultStorage
    
    private let preferences: AppPrefferencesModel
    
    private let soundUtil: SoundUtil
    
    unowned var view: YesNoViewController!
    
    
    public func set(view: YesNoViewController) {
        self.view = view
    }
    
    init(storage: UserDefaultStorage){
        self.storage = storage
        self.preferences = storage.getAppPreferences()
        self.soundUtil = SoundUtil(enable: preferences.isEnabledSound, volume: preferences.volume)
    }
    
    func viewDidLoad(){
        self.view.updateViewWithPreferences(appPreferences: preferences)
    }
    
    func play(){
        self.soundUtil.play()
    }
    
}
