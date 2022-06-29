//
//  NotesInstuctionHeaderCell.swift
//  RS
//
//  Created by ICoon on 29.06.2022.
//

import UIKit

class NotesInstuctionHeaderCell: UITableViewCell {

    
    @IBOutlet weak var noteInstructionHeaderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func configure(model: NotesInstructionHeaderCellModel){
        self.noteInstructionHeaderLabel.text = model.info
    }
    
}
