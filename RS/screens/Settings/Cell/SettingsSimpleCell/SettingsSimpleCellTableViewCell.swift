//
//  SettingsSimpleCellTableViewCell.swift
//  RS
//
//  Created by ICoon on 27.07.2022.
//

import UIKit

class SettingsSimpleCellTableViewCell: UITableViewCell , SettingCell {
    

    private var callback: (() -> Void)? = nil
    
    
    @IBOutlet weak var label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onTap(_:))))
    }
    
    func update(with model: SettingsModel) {
        guard let m = model as? SettingsSimpleCellModel else {
            return
        }
        
        self.label.text = m.title
        self.callback = m.callback

    }
    
    @objc func onTap(_ sender: UITapGestureRecognizer? = nil){
        self.callback?()
    }
    
}
