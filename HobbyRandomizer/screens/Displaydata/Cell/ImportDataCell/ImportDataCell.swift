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
        self.exportLabel.text = Translations.DisplayData.makeImport
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
