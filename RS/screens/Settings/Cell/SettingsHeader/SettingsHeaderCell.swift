//
//  SettingsHeaderCell.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import UIKit

class SettingsHeaderCell: UITableViewCell {
    
    
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: SettingsHeaderCellModel){
        self.headerLabel.text = model.title
    }
    
}
