//
//  SettingsYesNoColors.swift
//  RS
//
//  Created by ICoon on 29.06.2022.
//

import UIKit

class SettingsColorCell: UITableViewCell, SettingCell {
   
    
    
    
    private  var callback: ((_ text: String, _ newColor: Color) -> Void)? = nil

    @IBOutlet weak var setColorLabel: UILabel!
    
    @IBOutlet weak var colorIndicator: UIView!
    
    private var text: String = ""
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.colorIndicator.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onColorTapped(_:))))
        
        self.colorIndicator.border(color: UIColor.black)
    }
    
    
    func update(with model: SettingsModel) {
        guard let m = model as? SettingsColorCellModel else {
            return
        }
        
        self.text = m.title
        self.setColorLabel.text = Translations.SelectColor.selectColorTitle + "\(m.title)"
        self.colorIndicator.backgroundColor = m.currentColor
        self.callback = m.callback
    }
    
    @objc func onColorTapped(_ sender: UITapGestureRecognizer? = nil){
        self.callback?(self.text, Color(uiColor: self.colorIndicator.backgroundColor!))
    }
    
}
