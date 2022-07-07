//
//  ExportCell.swift
//  HobbyRandomizer
//
//  Created by ICoon on 23.06.2022.
//

import UIKit

class ActionButtonCell: UITableViewCell {
    
    
    @IBOutlet weak var removeData: LabelWithCallBack!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.removeData.text = Translations.Create.clearAll
    }
    
    func setupDelegate(callback:  (() -> Void )?){
        self.removeData.callback = callback
    }
    
}
