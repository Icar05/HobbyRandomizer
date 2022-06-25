//
//  ExportCell.swift
//  HobbyRandomizer
//
//  Created by ICoon on 23.06.2022.
//

import UIKit

class ExportCell: UITableViewCell {
    
    
    @IBOutlet weak var exportData: LabelWithCallBack!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.exportData.text = Translations.Create.makeExport
    }
    
    func setupDelegate(callback:  (() -> Void )?){
        self.exportData.callback = callback
    }
    
}
