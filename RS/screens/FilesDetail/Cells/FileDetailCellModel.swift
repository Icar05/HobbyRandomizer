//
//  FileDetailCellModel.swift
//  RS
//
//  Created by ICoon on 11.09.2022.
//

import Foundation


struct FileDetailCellModel{
    var fileName: String
    var fileFullName: String
}


extension FileInfo{
    func toFileDetailCellModel() -> FileDetailCellModel{
        return FileDetailCellModel(fileName: self.shortName, fileFullName: self.fullName)
    }
}
