//
//  KeyValueCell.swift
//  RS
//
//  Created by Галяткин Александр on 26.01.2023.
//

import UIKit

class KeyValueCell: UITableViewCell, ReportCell {
    
    @IBOutlet weak var keyLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with model: ReportModel) {
        guard let m = model as? KeyValueCellModel else {
            return
        }
        self.keyLabel.text = m.key
        self.valueLabel.text = m.value
    }
    
}

