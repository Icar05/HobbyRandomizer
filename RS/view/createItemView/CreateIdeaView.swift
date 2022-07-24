//
//  CreateIdeaView.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 13.10.2021.
//

import Foundation
import UIKit

protocol CreateViewDelegate: NSObject{
    func onItemCreated(item: RandItemCellModel)
}

@IBDesignable
class CreateIdeaView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
   
    

    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var descTextField: UITextField!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var createBtn: UIImageView!
    
    weak var delegate: CreateViewDelegate? = nil
    
    var type: ItemType = .HardDayNight
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareView()
    }
    
    
    func prepareView(){
        
        let bundle = Bundle(for: CreateIdeaView.self)
        bundle.loadNibNamed(String(describing: CreateIdeaView.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask =
            [UIView.AutoresizingMask.flexibleWidth,
             UIView.AutoresizingMask.flexibleHeight]


        self.layer.masksToBounds = true
        
        createBtn.isUserInteractionEnabled = true
        createBtn.border()
        
        self.picker.delegate = self
        self.picker.dataSource = self
        self.picker.selectRow(1, inComponent: 0, animated: true)

        let gest = UITapGestureRecognizer(target: self, action: #selector(grabData(tapGestureRecognizer:)))
        createBtn.addGestureRecognizer(gest)
        
        titleTextField.placeholder = Translations.Create.newIdeaTitle
        descTextField.placeholder = Translations.Create.newIdeaDescription
    }
    
    
    @objc func grabData(tapGestureRecognizer: UITapGestureRecognizer){
        let title: String? = self.getData(field: titleTextField)?.trimmingCharacters(in: .whitespaces)
        let subtitle: String? = self.getData(field: descTextField)?.trimmingCharacters(in: .whitespaces)
        
        if(title != nil && subtitle != nil){
            let model = RandItemCellModel(title: title!, subTitle: subtitle!, type: type)
            self.delegate?.onItemCreated(item: model)
            self.titleTextField.text = ""
            self.descTextField.text = ""
            self.picker.selectRow(1, inComponent: 0, animated: true)
        }
        
        contentView.endEditing(true)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ItemType.allCases[row].getTitle()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ItemType.allCases.count - 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.type =  ItemType.allCases[row]
    }
    
    @objc fileprivate func getData(field: UITextField) ->  String?{
        
        if(field.text != nil && !field.text!.isEmpty){
            return field.text
        }
        
        return nil
    }
    
}
