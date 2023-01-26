//
//  ReloadReportCellModel.swift
//  RS
//
//  Created by Галяткин Александр on 26.01.2023.
//

import Foundation


struct ReloadReportCellModel: ReportModel{
    let callback: () -> Void
    var reuseIdentifier: String = String(describing: ReloadReportCell.self)
}
