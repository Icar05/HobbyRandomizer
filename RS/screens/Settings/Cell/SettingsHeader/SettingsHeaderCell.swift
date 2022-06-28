//
//  SettingsHeaderCell.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import UIKit

class SettingsHeaderCell: UITableViewCell, SettingCell {
   
    
    
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with model: SettingsModel) {
        guard let m = model as? SettingsHeaderCellModel else {
            return
        }
        self.headerLabel.text = m.title
    }
    
}
