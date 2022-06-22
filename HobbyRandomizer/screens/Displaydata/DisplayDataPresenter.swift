//
//  DisplayDataPresenter.swift
//  HobbyRandomizer
//
//  Created by ICoon on 23.06.2022.
//

import Foundation

class DisplayDataPresenter{
    
    
    
    private let stringData: String
    
    private let contentData: [RandItemCellModel]
    
    unowned var view: DisplayDataViewController!
    
    public func set(view: DisplayDataViewController) {
        self.view = view
    }
    
    init(data: String){
        self.stringData = data
        self.contentData = []
    }
    
    init(data: [RandItemCellModel]){
        self.contentData = data
        self.stringData = ""
    }
    
    func viewDidLoad(){
        contentData.isEmpty ? view.displayData(data: stringData) : view.displayData(data: contentData)
    }
    
}
