//
//  DebugPresenter.swift
//  RS
//
//  Created by ICoon on 29.06.2022.
//

import Foundation

public final class DebugPresenter{
    
    
    private let storage: UserDefaultStorage
    
    private let soundUtil: SoundUtil
    
    unowned var view: DebugViewController!
    
    
    public func set(view: DebugViewController) {
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
