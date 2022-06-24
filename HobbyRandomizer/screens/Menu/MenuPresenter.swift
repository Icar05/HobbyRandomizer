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
//            MenuCellModel(
//                icon:UIImage(systemName: "plus.rectangle.fill.on.folder.fill")!,
//                type: .Create,
//                title: Translations.Menu.itemCreate
//            ),
            MenuCellModel(
                icon:  UIImage(systemName: "wrench.fill")!,
                type: .Test,
                title: Translations.Menu.itemTest
            ),
            MenuCellModel(
                icon:  UIImage(systemName: "suit.spade.fill")!,
                type: .Casino,
                title: Translations.Menu.itemCasino
            ),
            MenuCellModel(
                icon:  UIImage(systemName: "filemenu.and.cursorarrow")!,
                type: .Todo,
                title: Translations.Menu.itemTodo
            ),
            MenuCellModel(
                icon:  UIImage(systemName: "chart.line.uptrend.xyaxis")!,
                type: .WorkInProgress,
                title: Translations.Menu.itemWorkInProgress
            ),
            MenuCellModel(
                icon:  UIImage(systemName: "gamecontroller.fill")!,
                type: .Hobby,
                title: Translations.Menu.itemHobby
            ),
            MenuCellModel(
                icon:  UIImage(systemName: "folder")!,
                type: .Files,
                title: Translations.Menu.itemFiles
            )
        ]
    }
    
    
}
