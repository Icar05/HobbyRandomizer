//
//  SelectColorCell.swift
//  RS
//
//  Created by ICoon on 30.06.2022.
//

import UIKit


class SelectColorCell: UITableViewCell {

    
    
    @IBOutlet weak var selectColorLabel: UILabel!
    
    @IBOutlet weak var selectColorView: UIView!
    
    @IBOutlet weak var selectColorPicker: UIPickerView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func configure(model: SelectColorCellModel){
        self.selectColorLabel.text = "\(Translations.SelectColor.selectColorTitle) \(model.type.getTitle())"
        self.selectColorView.backgroundColor = model.color.uiColor
        //todo set selector with values
    }
    
}
