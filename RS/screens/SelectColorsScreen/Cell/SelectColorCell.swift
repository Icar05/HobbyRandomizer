//
//  SelectColorCell.swift
//  RS
//
//  Created by ICoon on 30.06.2022.
//

import UIKit


class SelectColorCell: UITableViewCell {

    private var callback: ((_ for: SelectType, _ newColor: Color) -> Void)? = nil
    
    private var type: SelectType? = nil
    
    private let colors: [Color] = [
        Color.init(uiColor: UIColor.red),
        Color.init(uiColor: UIColor.orange),
        Color.init(uiColor: UIColor.yellow),
        Color.init(uiColor: UIColor.green),
        Color.init(uiColor: UIColor.lightBlue!),
        Color.init(uiColor: UIColor.blue),
        Color.init(uiColor: UIColor.purple),
    ]
    
    private var selectedRow = 0
    
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
        self.selectColorPicker.selectRow(selectedRow, inComponent: 0, animated: true)
    }
    
    
    func configure(model: SelectColorCellModel){
        
        let text = "\(Translations.SelectColor.selectColorTitle) \(model.type.getTitle())"
        
        self.selectColorLabel.text = text
        self.selectColorView.backgroundColor = model.color.uiColor
        self.selectedRow = colors.firstIndex(of: model.color) ?? 0
        self.callback = model.callback
        self.type = model.type
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
        return "\(colors[row].getName())"
    }
}

extension SelectColorCell: UIPickerViewDelegate{
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let color = self.colors[row]
        self.selectColorView.backgroundColor = color.uiColor
        self.callback?(self.type!, color)
    }
}
