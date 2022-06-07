//
//  MenuPresenter.swift
//  HobbyRandomizer
//
//  Created by ICoon on 07.06.2022.
//

import Foundation

public final class MenuPresenter{
    
    
    unowned var view: MenuViewController!
    
    
    
    
    public func set(view: MenuViewController) {
        self.view = view
    }
    
    func viewDidLoad(){
        let data = prepareDataSource()
        self.view.didDataUpdate(data: data)
    }
    
    private func prepareDataSource() -> [MenuCellModel]{
        return [
            MenuCellModel(icon: nil, title: "title 1"),
            MenuCellModel(icon: nil, title: "title 2"),
            MenuCellModel(icon: nil, title: "title 3"),
            MenuCellModel(icon: nil, title: "title 4"),
        ]
    }
    
}
