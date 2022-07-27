//
//  SettingsYesNoCountCell.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import UIKit

class SettingsStepperCell: UITableViewCell, SettingCell {
   
    

    
    private var callback: ((_ value: Double) -> Void)? = nil
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.stepper.addTarget(self, action: #selector(onLuminosityChange), for: .valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func onLuminosityChange(stepper: UIStepper){
        self.title.text = Translations.Settings.count + ": \(Int(stepper.value))"
        self.callback?(stepper.value)
    }
    
    
    func update(with model: SettingsModel) {
        guard let settingModel = model as? SettingsSteppperCellModel else{
            return
        }
        
        let text = settingModel.title + ": \(Int(settingModel.value))"
        self.stepper.maximumValue = settingModel.maxValue
        self.stepper.minimumValue = settingModel.minValue
        self.stepper.value = settingModel.value
        self.title.text = text
        self.callback = settingModel.callback
    }
    
}
