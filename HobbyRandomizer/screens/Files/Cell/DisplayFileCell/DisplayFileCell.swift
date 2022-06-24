//
//  DisplayFileCell.swift
//  HobbyRandomizer
//
//  Created by ICoon on 23.06.2022.
//

import UIKit

class DisplayFileCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var filePathLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: DisplayFileCellModel){
        self.title.text = model.fileName
    }
    
}
