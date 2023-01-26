//
//  ReportEmptyCell.swift
//  RS
//
//  Created by Галяткин Александр on 26.01.2023.
//

import UIKit

class ReportEmptyCell: UITableViewCell, ReportCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func update(with model: ReportModel) {}
    
}
