//
//  DisplayQuestionCell.swift
//  RS
//
//  Created by ICoon on 29.06.2022.
//

import UIKit

class DisplayQuestionCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: DisplayQuestionCellModel){
        self.title.text = model.text
    }
    
}
