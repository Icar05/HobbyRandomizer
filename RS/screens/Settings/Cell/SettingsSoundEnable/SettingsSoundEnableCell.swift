//
//  SettingsSoundEnableCell.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import UIKit

class SettingsSoundEnableCell: UITableViewCell {

    
    
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
    
    func configure(model: SettingsSoundEnableCellModel){
        self.soundLabel.text = model.title
        self.soundSwitch.isOn = model.enable
        self.callback = model.callback
    }

    @objc func switchChanged(mySwitch: UISwitch) {
        self.callback?(mySwitch.isOn)
    }
}
