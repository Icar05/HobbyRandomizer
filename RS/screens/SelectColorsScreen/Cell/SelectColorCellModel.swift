//
//  SelectColorCellModel.swift
//  RS
//
//  Created by ICoon on 30.06.2022.
//

import Foundation

struct SelectColorCellModel{
    var type: SelectType
    var color: Color
    var callback: (_ for: SelectType, _ newColor: Color) -> Void
}
