//
//  TimerPresenter.swift
//  RS
//
//  Created by ICoon on 27.07.2022.
//

import Foundation

public final class TimerPresenter{
    
    
    private let storage: UserDefaultStorage
    
    private let preferences: AppPrefferencesModel
        
    unowned var view: TimerViewController!
    
    
    public func set(view: TimerViewController) {
        self.view = view
    }
    
    init(storage: UserDefaultStorage){
        self.storage = storage
        self.preferences = storage.getAppPreferences()
    }
    
    func viewDidLoad(){
        self.view.updateViewWithPreferences(appPreferences: preferences)
    }
    
}
