//
//  DisplayFileCellModel.swift
//  HobbyRandomizer
//
//  Created by ICoon on 23.06.2022.
//

import Foundation

struct DisplayFileCellModel{
    var fileName: String
    var fileFullName: String
}

extension FileInfo{
    func toDisplayFileCellModel() -> DisplayFileCellModel{
        return DisplayFileCellModel(fileName: self.shortName, fileFullName: self.fullName)
    }
}
