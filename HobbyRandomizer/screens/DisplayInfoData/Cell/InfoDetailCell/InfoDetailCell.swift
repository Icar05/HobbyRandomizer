//
//  InfoDetailCell.swift
//  RS
//
//  Created by ICoon on 27.06.2022.
//

import UIKit

class InfoDetailCell: UITableViewCell {

    
    
    @IBOutlet weak var infoDetailLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(value: String){
        self.infoDetailLabel.text =  value
    }
}
