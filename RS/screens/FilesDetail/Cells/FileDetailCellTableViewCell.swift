//
//  FileDetailCellTableViewCell.swift
//  RS
//
//  Created by ICoon on 11.09.2022.
//

import UIKit

class FileDetailCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var filePathLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: FileDetailCellModel){
        self.title.text = model.fileName
    }
    
}
