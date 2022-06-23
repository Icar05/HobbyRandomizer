//
//  CasinoViewController.swift
//  HobbyRandomizer
//
//  Created by ICoon on 08.06.2022.
//

import UIKit

class CasinoViewController: UIViewController {
    
    
    fileprivate var datasourse = [Int]()
    
    fileprivate var currentSelectedIndex = 0
    
    @IBOutlet weak var doneButton: LabelWithCallBack!
    
    @IBOutlet weak var picker: SilintUIPickerView!
    
    @IBOutlet weak var rouleteView: RouleteView!
    
    @IBOutlet weak var hiddenView: UIView!
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: "CasinoViewController", bundle: Bundle.main)
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.hiddenView.alpha = 0.0
        self.datasourse = rouleteView.getDataSource()
        self.picker.dataSource = self
        self.picker.delegate = self
        self.picker.selectRow(currentSelectedIndex, inComponent: 0, animated: true)
        self.picker.setSoundsEnabled(false)
        
        rouleteView.isUserInteractionEnabled = true
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(CasinoViewController.handleTap(_:)))
        tapGR.delegate = self
        tapGR.numberOfTapsRequired = 3
        rouleteView.addGestureRecognizer(tapGR)
        
        self.doneButton.callback = {
            self.showHiddenView(value: true)
            self.rouleteView.targetIndex = self.currentSelectedIndex
        }
        
    }
    
    private func showHiddenView(value: Bool){
        UIView.animate(withDuration: 1.0) {
                self.hiddenView.alpha = !value ? 1.0 : 0.0
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
        self.showHiddenView(value: false)
    }
}

extension CasinoViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currentSelectedIndex = row
        self.rouleteView.targetIndex = currentSelectedIndex
    }
}
