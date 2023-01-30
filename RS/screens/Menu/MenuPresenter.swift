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
            MenuCellModel(
                icon:UIImage(systemName: "doc.text")!,
                type: .RandomReport,
                title: Translations.Settings.randomReport
            ),
            MenuCellModel(
                icon:  UIImage(systemName: "flag.filled.and.flag.crossed")!,
                type: .YesNo,
                title: Translations.Menu.itemYesNo
            ),
            MenuCellModel(
                icon:  UIImage(systemName: "suit.spade")!,
                type: .Casino,
                title: Translations.Menu.itemCasino
            ),
            MenuCellModel(
                icon:  UIImage(systemName: "filemenu.and.cursorarrow")!,
                type: .Todo,
                title: Translations.Menu.itemTodo
            ),
            MenuCellModel(
                icon:  UIImage(systemName: "sunset")!,
                type: .HardDayNight,
                title: Translations.Menu.itemHardDayNight
            ),
            MenuCellModel(
                icon:  UIImage(systemName: "takeoutbag.and.cup.and.straw")!,
                type: .WeekEnd,
                title: Translations.Menu.itemWeekend
            ),
            MenuCellModel(
                icon:  UIImage(systemName: "timer")!,
                type: .Timer,
                title: Translations.Menu.itemTimer
            ),
            MenuCellModel(
                icon:  UIImage(systemName: "folder")!,
                type: .Files,
                title: Translations.Menu.itemFiles
            ),
            MenuCellModel(
                icon:  UIImage(systemName: "gearshape")!,
                type: .Settings,
                title: Translations.Settings.settings
            )
        ]
    }
    
    
}
