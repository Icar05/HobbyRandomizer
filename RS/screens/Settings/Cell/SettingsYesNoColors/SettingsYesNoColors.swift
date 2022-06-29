//
//  SettingsYesNoColors.swift
//  RS
//
//  Created by ICoon on 29.06.2022.
//

import UIKit

class SettingsYesNoColors: UITableViewCell, SettingCell {
   

    @IBOutlet weak var setColorLabel: UILabel!
    
    @IBOutlet weak var noViewColor: UIView!
    
    @IBOutlet weak var yesViewColor: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func update(with model: SettingsModel) {
        guard let m = model as? SettingsYesNoColorsModel else {
            return
        }
        
        self.setColorLabel.text = m.title
        self.yesViewColor.backgroundColor = m.yesColor
        self.noViewColor.backgroundColor = m.noColor
    }
    
}
