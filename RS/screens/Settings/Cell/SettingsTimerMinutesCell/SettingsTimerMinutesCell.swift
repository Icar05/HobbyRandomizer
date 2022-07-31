//
//  SettingsTimerMinutesCell.swift
//  RS
//
//  Created by ICoon on 01.08.2022.
//

import UIKit

class SettingsTimerMinutesCell: UITableViewCell, SettingCell{
    
    
    
    private var callback: ((_ value: Int) -> Void)? = nil
    
    @IBOutlet weak var minutesSlider: UISlider!
    
    @IBOutlet weak var minutesLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.minutesSlider.addTarget(self, action: #selector(onTimeChanged), for: .valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func update(with model: SettingsModel) {
        guard let m = model as? SettingsTimerMinutesCellModel else {
            return
        }
        
        self.minutesLabel.text = "\(Translations.Settings.timerMaxLabel) \(m.minutes)"
        self.minutesSlider.value  = Float(m.minutes)
        self.callback = m.callback
    }
    
    @objc func onTimeChanged(slider: UISlider){
        self.minutesLabel.text = "\(Translations.Settings.timerMaxLabel) \(Int(slider.value))"
        self.callback?(Int(slider.value))
    }
    
}

    
    
   
    
