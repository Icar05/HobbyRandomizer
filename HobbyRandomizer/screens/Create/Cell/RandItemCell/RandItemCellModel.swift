//
//  RandItemCellModel.swift
//  HobbyRandomizer
//
//  Created by ICoon on 08.06.2022.
//

import Foundation

enum ItemType: String, Codable, CaseIterable{
    case necessary, freetime, workInProgress
}

struct RandItemCellModel: Codable{
    var title: String
    var subTitle: String
    var type: ItemType
}

extension ItemType{
    
    func getImage() -> UIImage{
        switch self {
        case .necessary:
            return UIImage(source: "work", bundle: .main)!
        case .freetime:
            return UIImage(source: "hobby", bundle: .main)!
        case .workInProgress:
            return UIImage(source: "progress", bundle: .main)!
        }
    }
    
    func getColorForType() -> UIColor{
        switch self {
        case .necessary:
            return UIColor.coolRed!
        case .freetime:
            return UIColor.coolGreen!
        case .workInProgress:
            return UIColor.coolOrange!
        }
    }
}
