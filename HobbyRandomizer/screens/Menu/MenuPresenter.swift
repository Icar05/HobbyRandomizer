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
            MenuCellModel(icon:  UIImage(systemName: "plus.rectangle.fill.on.folder.fill")!, type: .Create),
            MenuCellModel(icon:  UIImage(systemName: "wrench.fill")!, type: .Test),
            MenuCellModel(icon:  UIImage(systemName: "suit.spade.fill")!, type: .Casino),
        ]
    }
    
    
}
