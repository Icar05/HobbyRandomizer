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
    
    func viewDidLoad(){}
    
}
