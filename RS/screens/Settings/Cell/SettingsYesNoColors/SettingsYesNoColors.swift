//
//  SettingsYesNoColors.swift
//  RS
//
//  Created by ICoon on 29.06.2022.
//

import UIKit

class SettingsYesNoColors: UITableViewCell, SettingCell {
   
    
    
    
    private var callback: (() -> Void)? = nil

    @IBOutlet weak var setColorLabel: UILabel!
    
    @IBOutlet weak var noViewColor: UIView!
    
    @IBOutlet weak var yesViewColor: UIView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.yesViewColor.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onColorTapped(_:))))
        self.noViewColor.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onColorTapped(_:))))
    }
    
    
    func update(with model: SettingsModel) {
        guard let m = model as? SettingsYesNoColorsModel else {
            return
        }
        
        self.setColorLabel.text = m.title
        self.yesViewColor.backgroundColor = m.yesColor
        self.noViewColor.backgroundColor = m.noColor
        self.callback = m.callback
    }
    
    @objc func onColorTapped(_ sender: UITapGestureRecognizer? = nil){
        print("it's work!")
        self.callback?()
    }
    
}
