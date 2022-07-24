//
//  RandItemCellModel.swift
//  HobbyRandomizer
//
//  Created by ICoon on 08.06.2022.
//

import Foundation

enum ItemType: String, Codable, CaseIterable{
    case ToDo, HardDayNight, HappyWeekend
}

struct RandItemCellModel: Codable{
    var title: String
    var subTitle: String
    var type: ItemType
}

extension ItemType{
    
    func getTitle() -> String{
        switch self {
        case .ToDo:
            return Translations.Create.typeTodo
        case .HardDayNight:
            return Translations.Create.typeHardDayNight
        case .HappyWeekend:
            return Translations.Create.typeHappyWeekend
        }
    }
    
    func getImage() -> UIImage{
        switch self {
        case .ToDo:
            return UIImage(source: "work", bundle: .main)!
        case .HardDayNight:
            return UIImage(source: "party", bundle: .main)!
        case .HappyWeekend:
            return UIImage(source: "weekend", bundle: .main)!
        }
    }
    
    func getColorForType() -> UIColor{
        switch self {
        case .ToDo:
            return UIColor.colorCocoa!
        case .HardDayNight:
            return UIColor.colorCoolViolet!
        case .HappyWeekend:
            return UIColor.coolOrange!
        }
    }
}
