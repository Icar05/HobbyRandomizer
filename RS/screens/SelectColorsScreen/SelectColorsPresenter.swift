//
//  SelectColorsPresenter.swift
//  RS
//
//  Created by ICoon on 29.06.2022.
//

import Foundation

public final class SelectColorsPresenter{
    
    
    private let storage: UserDefaultStorage
        
    unowned var view: SelectColorsViewController!
    
    public func set(view: SelectColorsViewController) {
        self.view = view
    }
    
    init(storage: UserDefaultStorage){
        self.storage = storage
    }
    
    func viewDidLoad(){
        
        let preferences = storage.getAppPreferences()
        let models: [SelectColorModel] = [
            SelectColorModel(type: .YES, color: preferences.yesColor),
            SelectColorModel(type: .NO, color: preferences.noColor)
        ]
        view.displayData(data: models)
    }
    
}

