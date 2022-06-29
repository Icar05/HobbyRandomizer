//
//  SelectColorsPresenter.swift
//  RS
//
//  Created by ICoon on 29.06.2022.
//

import Foundation

public final class SelectColorsPresenter{
    
    
    private let storage: UserDefaultStorage
    
    private var preferences: AppPrefferencesModel
        
    unowned var view: SelectColorsViewController!
    
    public func set(view: SelectColorsViewController) {
        self.view = view
    }
    
    init(storage: UserDefaultStorage){
        self.storage = storage
        self.preferences = storage.getAppPreferences()
    }
    
    func viewDidLoad(){
        
        let models: [SelectColorModel] = [
            SelectColorModel(type: .YES, color: preferences.yesColor),
            SelectColorModel(type: .NO, color: preferences.noColor)
        ]
        view.displayData(data: models)
    }
    
    func colorDidChange(type: SelectType, color: Color){
        if(type == .YES){
            self.preferences.yesColor = color
        }else{
            self.preferences.noColor = color
        }
    }
    
    func savePreferences(){
        self.storage.saveAppPreferences(model: preferences)
    }
    
}

