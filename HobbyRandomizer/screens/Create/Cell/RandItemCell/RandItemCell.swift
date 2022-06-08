//
//  RandItemCell.swift
//  HobbyRandomizer
//
//  Created by ICoon on 08.06.2022.
//

import UIKit

class RandItemCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var subTitle: UILabel!
            
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var statusImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: RandItemCellModel){
        self.title.text = model.title
        self.subTitle.text = model.subTitle
        self.icon.setImageColor(color: getColorForType(type: model.type))
    }
    
    private func getColorForType(type: ItemType) -> UIColor{
        switch type {
        case .necessary:
            return UIColor.coolRed!
        case .freetime:
            return UIColor.coolGreen!
        case .workInProgress:
            return UIColor.coolOrange!
        }
    }
    
}
