//
//  KeyValueCellModel.swift
//  RS
//
//  Created by Галяткин Александр on 26.01.2023.
//

import Foundation

struct KeyValueCellModel: ReportModel{
    let key: String
    let value: String
    var reuseIdentifier: String = String(describing: KeyValueCell.self)
}
