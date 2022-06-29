//
//  SelectColorCell.swift
//  RS
//
//  Created by ICoon on 30.06.2022.
//

import UIKit


class SelectColorCell: UITableViewCell {

    
    private let colors: [Color] = [
        Color.init(uiColor: UIColor.red),
        Color.init(uiColor: UIColor.orange),
        Color.init(uiColor: UIColor.yellow),
        Color.init(uiColor: UIColor.green),
        Color.init(uiColor: UIColor.blue),
        Color.init(uiColor: UIColor.systemIndigo),
        Color.init(uiColor: UIColor.purple),
    ]
    
    
    
    @IBOutlet weak var selectColorLabel: UILabel!
    
    @IBOutlet weak var selectColorView: UIView!
    
    @IBOutlet weak var selectColorPicker: UIPickerView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectColorPicker.dataSource = self
        self.selectColorPicker.delegate = self
    }
    
    
    func configure(model: SelectColorCellModel){
        
        let index = colors.firstIndex{ $0 == model.color } ?? 0
        
        self.selectColorLabel.text = "\(Translations.SelectColor.selectColorTitle) \(model.type.getTitle())"
        self.selectColorView.backgroundColor = model.color.uiColor
        self.selectColorPicker.selectRow(index, inComponent: 0, animated: true)
    }
    
}


extension SelectColorCell: UIPickerViewDataSource{
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(colors[row])"
    }
}

extension SelectColorCell: UIPickerViewDelegate{
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectColorView.backgroundColor = self.colors[row].uiColor
    }
}
