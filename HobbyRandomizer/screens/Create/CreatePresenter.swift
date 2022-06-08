//
//  MainViewModel.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 13.10.2021.
//

import Foundation

public final class CreatePresenter {
  

    fileprivate let storage: UserDefaultStorage
    
    unowned var view: CreateViewController!
    

    init(storage: UserDefaultStorage){
        self.storage = storage
    }
    
    public func set(view: CreateViewController) {
        self.view = view
    }
    
    func viewDidLoad(){
        self.view.onModelLoaded(models: getMockModels())
    }
    
    func saveModels(models: [RandItemCellModel]){
        self.storage.saveModels(models: models)
    }
    
    #warning("todo remove mock")
    func getMockModels() -> [RandItemCellModel]{
        return [RandItemCellModel].init(repeating: RandItemCellModel(title: "Title", subTitle: "subtitle"), count: 10)
    }
    
    func getModels() -> [RandItemCellModel]{
        self.storage.getModels() ?? []
    }

}
