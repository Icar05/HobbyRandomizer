//
//  CasinoViewController.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 15.10.2021.
//

import UIKit

class CasinoViewController : UIViewController {
    
    
    
    fileprivate var datasourse = [Int]()
    
    fileprivate var pickerShown = false
    
    fileprivate var currentSelectedIndex = 0
    
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var rouleteView: RouleteView!
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var bottomView: UIView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.changePickerVisibility(visible: self.pickerShown)
        self.datasourse = rouleteView.getDataSource()
        self.picker.dataSource = self
        self.picker.delegate = self
        self.picker.selectRow(currentSelectedIndex, inComponent: 0, animated: true)
        
        
        rouleteView.isUserInteractionEnabled = true
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(CasinoViewController.handleTap(_:)))
            tapGR.delegate = self
            tapGR.numberOfTapsRequired = 3
        rouleteView.addGestureRecognizer(tapGR)
        
    }

    fileprivate func toggleShowPicker(){
        self.pickerShown = !self.pickerShown
        self.changePickerVisibility(visible: self.pickerShown)
    }
    
    fileprivate func changePickerVisibility(visible: Bool){
        self.picker.isHidden = !visible
        self.topView.isHidden = !visible
        self.bottomView.isHidden = !visible
        
        if(!visible){
            self.rouleteView.clearTargetIndex()
        }else{
            self.rouleteView.targetIndex = self.currentSelectedIndex
        }
    }

    
}

extension CasinoViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datasourse.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(datasourse[row])"
    }
}

extension CasinoViewController: UIGestureRecognizerDelegate {
    @objc func handleTap(_ gesture: UITapGestureRecognizer){
        self.toggleShowPicker()
    }
}

extension CasinoViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currentSelectedIndex = row
        self.rouleteView.targetIndex = currentSelectedIndex
    }
}
