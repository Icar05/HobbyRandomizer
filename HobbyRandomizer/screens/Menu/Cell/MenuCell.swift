//
//  MenuCell.swift
//  HobbyRandomizer
//
//  Created by ICoon on 07.06.2022.
//

import UIKit

class MenuCell: UICollectionViewCell {

    
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func configure(model: MenuCellModel){
        self.icon.image = model.icon
        self.label.text = model.title
    }

}
