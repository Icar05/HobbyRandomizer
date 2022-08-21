//
//  TestViewController.swift
//  RS
//
//  Created by ICoon on 18.08.2022.
//

import UIKit
import BLEApi

class TestViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    private let client = BLEClientImpl()

    @IBOutlet weak var stateSwitch: UISwitch!
    
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var debugLabel: UILabel!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: "TestViewController", bundle: Bundle.main)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.stateSwitch.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        
        self.client.delegate = self
        self.stateLabel.text = "Api Disabled"
        
        
        self.client.sendString(value: "HAAI Rules!")
    }
    
    @objc func switchChanged(mySwitch: UISwitch) {
        self.stateLabel.text = mySwitch.isOn ?  "Stop servise" : "Start Service"
        mySwitch.isOn ?  client.startBLEApi() : client.stopBLEApi()
    }

}

extension TestViewController: BLEApiListener{
    
    
    
    func displayTransportInformation(value: String) {
        DispatchQueue.main.async { [weak self] in
            self?.appendText(newValue: value, color: UIColor.orange)
        }
    }
    
    func displayConnectionInformation(value: String) {
        DispatchQueue.main.async { [weak self] in
            self?.appendText(newValue: value, color: UIColor.blue)
        }
    }
    
    func displayDisccoveringInforamtion(value: String) {
        DispatchQueue.main.async { [weak self] in
            self?.appendText(newValue: value, color: UIColor.green)
        }
    }
    
    func displayExtraInformation(value: String) {
        DispatchQueue.main.async { [weak self] in
            self?.appendText(newValue: value, color: UIColor.brown)
        }
    }
    
    
    func didStopManager(value: String) {
        DispatchQueue.main.async { [weak self] in
            self?.appendText(newValue: value, color: UIColor.blue)
            self?.stateSwitch.setOn(false, animated: true)
            self?.stateLabel.text = "Start Service"
        }
    }
    
    func didStartManager(value: String) {
        DispatchQueue.main.async { [weak self] in
            self?.debugLabel.attributedText = NSAttributedString(string: "")
            self?.errorLabel.text = ""
            self?.appendText(newValue: value, color: UIColor.blue)
        }
    }
    
    func displayError(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.errorLabel.text = error
        }
    }
    
    func didBluetoothStateChanged(value: String) {
        DispatchQueue.main.async { [weak self] in
            self?.appendText(newValue: value, color: UIColor.blue)
        }
    }
    
    
    private func appendText(newValue: String, color: UIColor){
        let combination = NSMutableAttributedString()
        let prevText = self.debugLabel.attributedText ?? NSAttributedString.init(string: "")
        let newText = colorString(value: newValue + "\n", color: color)
        combination.append(prevText)
        combination.append(newText)
        self.debugLabel.attributedText = combination
    }
    
    private func colorString(value: String, color: UIColor) -> NSAttributedString{
        return NSAttributedString(
            string: value,
            attributes: [NSAttributedString.Key.foregroundColor : color])
    }
    
}
