//
//  DisplayInfoDataPresenter.swift
//  RS
//
//  Created by ICoon on 26.06.2022.
//

import Foundation

public final class DisplayInfoDataPresenter{
    
    
    
    private let storage: UserDefaultStorage
        
    private let contentData: [InfoModel]
    
    unowned var view: DisplayInfoDataViewController!
    
    public func set(view: DisplayInfoDataViewController) {
        self.view = view
    }
    
    init(data: [InfoModel], storage: UserDefaultStorage){
        self.storage = storage
        self.contentData = data
    }
    
    func viewDidLoad(){
        view.displayData(data: contentData)
    }

}
