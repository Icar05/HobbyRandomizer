//
//  NotesInstructionInfoCell.swift
//  RS
//
//  Created by ICoon on 29.06.2022.
//

import UIKit

class NotesInstructionInfoCell: UITableViewCell {

    
    @IBOutlet weak var noteInstructionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: NotesInstuctionInfoCellModel){
        self.noteInstructionLabel.text = model.info
    }
    
}
