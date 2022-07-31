//
//  SettingsVolumeCell.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import UIKit

class SettingsVolumeCell: UITableViewCell, SettingCell {
    
    
    private var callback: ((_ value: Float) -> Void)? = nil
    
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBOutlet weak var volumeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.volumeSlider.addTarget(self, action: #selector(onLuminosityChange), for: .valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func update(with model: SettingsModel) {
        guard let m = model as? SettingsVolumeCellModel else {
            return
        }
        
        self.volumeLabel.text = "\(Translations.Settings.soundVolume) \(getPercent(volume: m.volume)) %"
        self.volumeSlider.value  = m.volume
        self.callback = m.callback
    }
    
    @objc func onLuminosityChange(slider: UISlider){
        self.volumeLabel.text = "\(Translations.Settings.soundVolume) \(getPercent(volume: slider.value)) %"
        self.callback?(slider.value)
    }
    
    private func getPercent(volume: Float) -> Int{
        return Int(volume * 100)
    }
    
}
