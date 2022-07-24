//
//  ImportDataCell.swift
//  RS
//
//  Created by ICoon on 25.06.2022.
//

import UIKit

class ImportDataCell: UITableViewCell {

    
    @IBOutlet weak var exportLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: ImportDataCellModel){
        self.exportLabel.text = model.title
    }
    
}
