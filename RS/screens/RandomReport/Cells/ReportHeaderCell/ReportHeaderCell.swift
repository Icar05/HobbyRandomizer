//
//  ReportHeaderCell.swift
//  RS
//
//  Created by Галяткин Александр on 26.01.2023.
//

import UIKit

class ReportHeaderCell: UITableViewCell, ReportCell {
    
    
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with model: ReportModel) {
        guard let m = model as? ReportHeaderCellModel else {
            return
        }
        self.headerLabel.text = m.title
    }
    
}


