//
//  ReportHeaderCellModel.swift
//  RS
//
//  Created by Галяткин Александр on 26.01.2023.
//

import Foundation


struct ReportHeaderCellModel: ReportModel{
    let title: String
    var reuseIdentifier: String = String(describing: ReportHeaderCell.self)
}
