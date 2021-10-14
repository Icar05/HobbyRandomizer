//
//  MainViewModel.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 13.10.2021.
//

import Foundation

class MainViewModel {
  

    fileprivate let storage = UserDefaultStorage()
    

    static var shared: MainViewModel = {
        let instance = MainViewModel()
   
        return instance
    }()

    private init() {}
    
    
    func saveModels(models: [HobbyModel]){
        self.storage.saveModels(models: models)
    }
    
    
    func getModels() -> [HobbyModel]?{
        self.storage.getModels()
    }

}
