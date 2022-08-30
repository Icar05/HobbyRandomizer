//
//  TestViewController.swift
//  RS
//
//  Created by ICoon on 18.08.2022.
//

import UIKit
import BLEApi

class TestViewController: UIViewController {
    
    
    private let colors: [InfoType: UIColor] = [
        .connection: UIColor.blue,
        .discovering: UIColor.systemGreen,
        .extra: UIColor.purple,
        .error: UIColor.red,
        .transportOut: UIColor.brown,
        .transportIn: UIColor.coolOrange!
    ]
    
    private let client = BLEClientImpl()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
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
        
//        self.client.delegate = self
        self.stateLabel.text = "Api Disabled"
        
        
        self.client.callback =  { status, percent, error, data in
            
            self.debugLabel.text = "\(status) : [\(percent)%] "
            
            if(error != nil){
                self.errorLabel.text = error
                self.stateSwitch.setOn(false, animated: true)
            }
            
            if(data != nil){
                self.debugLabel.text = String(data: data!, encoding: .utf8)
                self.stateSwitch.setOn(false, animated: true)
            }
            
        }
        
        let model = BLEApiData(
            data: Data(Test.getText().utf8),
            title: "Chemical brothers remix",
            info: "String data")
        
        self.client.sendData(data: model)
    }
    
    @objc func switchChanged(mySwitch: UISwitch) {
        self.stateLabel.text = mySwitch.isOn ?  "Stop servise" : "Start Service"
        mySwitch.isOn ?  client.startBLEApi() : client.stopBLEApi()
    }

}

extension TestViewController: BLEApiDelegate{
    
    
    func displayInfo(model: InfoData) {
        self.appendText(
            newValue: model.info,
            color: colors[model.type]!
        )
    }
    
    func displayTransportState(state: TransportState) {
        
    }
    
    func displayApiState(state: BLEApiDeviceState) {
        
    }
    
//    func didStopManager(value: String) {
//            self.appendText(newValue: value, color: self.connectionInfoColor )
//            self.stateSwitch.setOn(false, animated: true)
//            self.stateLabel.text = "Start Service"
//    }
//
//    func didStartManager(value: String) {
//            self.debugLabel.attributedText = NSAttributedString(string: "")
//            self.errorLabel.text = ""
//            self.appendText(newValue: value, color: self.connectionInfoColor)
//    }
//
//    func displayError(error: String) {
//            self.errorLabel.text = error
//            self.appendText(newValue: error, color: UIColor.red)
//    }
    
//    func didBluetoothStateChanged(value: String) {
//            self.appendText(newValue: value, color: self.connectionInfoColor)
//    }
    
    
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
