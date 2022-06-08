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
