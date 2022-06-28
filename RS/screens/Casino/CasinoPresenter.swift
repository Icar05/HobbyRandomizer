//
//  CasinoPresenter.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import Foundation

public final class CasinoPresenter{
    
    
    private let storage: UserDefaultStorage
    
    private let soundUtil: SoundUtil
    
    
    unowned var view: CasinoViewController!
    
    
    public func set(view: CasinoViewController) {
        self.view = view
    }
    
    init(storage: UserDefaultStorage){
        self.storage = storage
        
        let model = storage.getAppPreferences()
        self.soundUtil = SoundUtil(enable: model.isEnabledSound, volume: model.volume)
    }
    
    func viewDidLoad(){}
    
    func play(){
        self.soundUtil.play()
    }
    
}

