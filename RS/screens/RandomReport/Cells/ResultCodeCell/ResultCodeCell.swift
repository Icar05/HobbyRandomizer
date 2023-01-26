//
//  ResultCodeCell.swift
//  RS
//
//  Created by Галяткин Александр on 26.01.2023.
//

import UIKit

class ResultCodeCell: UITableViewCell, ReportCell {
    
    
    
    @IBOutlet weak var codeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with model: ReportModel) {
        guard let m = model as? ResultCodeCellModel else {
            return
        }
        self.codeLabel.text = m.code
    }
    
}
