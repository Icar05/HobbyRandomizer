//
//  ShowPresenter.swift
//  HobbyRandomizer
//
//  Created by ICoon on 09.06.2022.
//

import Foundation

public final class ShowPresenter{
    
    
    private let storage: UserDefaultStorage
    
    private let type: ItemType
    
    unowned var view: ShowViewController!
    
    public func set(view: ShowViewController) {
        self.view = view
    }
    
    init(storage: UserDefaultStorage, type: ItemType){
        self.storage = storage
        self.type = type
    }
    
    func viewDidLoad(){
        let content = storage.getModels()?.filter{$0.type == type} ?? []
        self.view.onDataLoaded(data: content)
    }
    
}
