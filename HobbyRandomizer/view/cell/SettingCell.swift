//
//  SettingCell.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 15.10.2021.
//

import UIKit

class SettingCell: UITableViewCell{
    
    
    @IBOutlet weak var settingIcon: UIImageView!
    
    @IBOutlet weak var settingLabel: UILabel!
    
    func setData(data: SettingsModel){
        self.settingIcon.image = data.image
        self.settingLabel.text = data.title
    }
}

