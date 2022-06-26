//
//  DisplayRawDataPresenter.swift
//  RS
//
//  Created by ICoon on 26.06.2022.
//

import Foundation

public final class DisplayRawDataPresenter {

    
    private let storage: UserDefaultStorage
    
    private let stringData: String
        
    unowned var view: DisplayRawDataViewController!
    
    public func set(view: DisplayRawDataViewController) {
        self.view = view
    }
    
    init(data: String, storage: UserDefaultStorage){
        self.storage = storage
        self.stringData = data
    }
    
    func viewDidLoad(){
        view.displayData(data: stringData)
    }
    
}

