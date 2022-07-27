//
//  SettingsSoundEnableCell.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import UIKit

class SettingsSwichCell: UITableViewCell, SettingCell {
    
    
    
    private var callback: ((_ value: Bool) -> Void)? = nil
    
    @IBOutlet weak var soundLabel: UILabel!
    
    @IBOutlet weak var soundSwitch: UISwitch!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.soundSwitch.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with model: SettingsModel) {
        guard let m = model as? SettingsSwichCellModel else {
            return
        }
        
        self.soundLabel.text = m.title
        self.soundSwitch.isOn = m.enable
        self.callback = m.callback
    }

    @objc func switchChanged(mySwitch: UISwitch) {
        self.callback?(mySwitch.isOn)
    }
}
