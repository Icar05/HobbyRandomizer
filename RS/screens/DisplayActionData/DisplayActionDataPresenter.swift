//
//  DisplayActionDataPresenter.swift
//  RS
//
//  Created by ICoon on 26.06.2022.
//

import Foundation

final class DisplayActionDataPresenter{
    
    private let storage: UserDefaultStorage
        
    private let contentData: [ActionModel]
    
    unowned var view: DisplayActionDataViewController!
    
    public func set(view: DisplayActionDataViewController) {
        self.view = view
    }
    
    init(data: [ActionModel], storage: UserDefaultStorage){
        self.storage = storage
        self.contentData = data
    }
    
    func viewDidLoad(){
        view.displayData(data: contentData)
    }
    
    func importData(){
        let success = storage.appendModels(newModels: contentData)
        view.onDataExported(value: success)
    }
}
