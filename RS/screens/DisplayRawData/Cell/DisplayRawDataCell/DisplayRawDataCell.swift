//
//  DisplayRawDataCell.swift
//  RS
//
//  Created by ICoon on 26.06.2022.
//

import UIKit

class DisplayRawDataCell: UITableViewCell {
    
    
    @IBOutlet weak var dataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: DisplayRawDataCellModel){
        self.dataLabel.text = model.data
    }
    
}
