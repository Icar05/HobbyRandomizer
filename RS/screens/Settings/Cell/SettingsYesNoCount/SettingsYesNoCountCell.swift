//
//  SettingsYesNoCountCell.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import UIKit

class SettingsYesNoCountCell: UITableViewCell, SettingCell {
   
    

    
    private var callback: ((_ value: Double) -> Void)? = nil
    
    @IBOutlet weak var yesNoCountLabel: UILabel!
    
    @IBOutlet weak var yesNoCountStepper: UIStepper!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.yesNoCountStepper.addTarget(self, action: #selector(onLuminosityChange), for: .valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func onLuminosityChange(stepper: UIStepper){
        self.yesNoCountLabel.text = Translations.Settings.count + ": \(Int(stepper.value))"
        self.callback?(stepper.value)
    }
    
    
    func update(with model: SettingsModel) {
        guard let settingModel = model as? SettingsYesNoCellModel else{
            return
        }
        
        let text = settingModel.title + ": \(Int(settingModel.value))"
        self.yesNoCountStepper.maximumValue = settingModel.maxValue
        self.yesNoCountStepper.minimumValue = settingModel.minValue
        self.yesNoCountStepper.value = settingModel.value
        self.yesNoCountLabel.text = text
        self.callback = settingModel.callback
    }
    
}
