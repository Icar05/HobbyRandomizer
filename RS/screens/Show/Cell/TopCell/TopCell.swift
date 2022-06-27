//
//  TopCell.swift
//  RS
//
//  Created by ICoon on 23.06.2022.
//

import UIKit

class TopCell: UITableViewCell {

    
    
    @IBOutlet weak var iv: UIImageView!
    
    @IBOutlet weak var label: LabelWithCallBack!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: ItemType, callback: @escaping () -> Void){
        self.iv.image = model.getImage()
        self.label.backgroundColor = model.getColorForType()
        self.label.text = Translations.Show.startRandom
        self.label.callback = callback
    }
    
}
