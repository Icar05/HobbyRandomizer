//
//  ResultCodeCellModel.swift
//  RS
//
//  Created by Галяткин Александр on 26.01.2023.
//

import Foundation

struct ResultCodeCellModel: ReportModel{
    let code: String
    let time: String
    var reuseIdentifier: String = String(describing: ResultCodeCell.self)
}
