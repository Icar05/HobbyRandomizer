//
//  TestViewController.swift
//  RS
//
//  Created by ICoon on 18.08.2022.
//

import UIKit
import BLEApi

class TestViewController: UIViewController {
    
    
    
    
    private let client = BLEClientImpl()
    
    private let connectionInfoColor = UIColor.blue
    
    private let discoveringInfoColor = UIColor.systemGreen
    
    private let extraInfoColor =  UIColor.systemPurple
    
    private let tranportInfoColor =  UIColor.systemTeal
    
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
        
        self.client.delegate = self
        self.stateLabel.text = "Api Disabled"
        
        
        let model = BLEApiData(
            data: Data("HAAI Rules!".utf8),
            title: "Chemical brothers remix",
            info: "String data")
        
        self.client.sendData(data: model)
    }
    
    @objc func switchChanged(mySwitch: UISwitch) {
        self.stateLabel.text = mySwitch.isOn ?  "Stop servise" : "Start Service"
        mySwitch.isOn ?  client.startBLEApi() : client.stopBLEApi()
    }

}

extension TestViewController: BLEApiListener{
    
    
    func displayTransferFinish(title: String, percent: Double, data: Data) {
        DispatchQueue.main.async { [weak self] in
            self?.appendText(
                newValue: "data (\(title)) has already loaded. Size: \(data.count)",
                color: self?.connectionInfoColor ?? UIColor.black
            )
        }
    }
    
    func displayTransferProgress(title: String, percent: Double, size: Double) {
        DispatchQueue.main.async { [weak self] in
            self?.appendText(newValue: "Loaded \(percent) % of \(title)", color: self?.tranportInfoColor ?? UIColor.black)
        }
    }

    func displayTransportInformation(value: String) {
        DispatchQueue.main.async { [weak self] in
            self?.appendText(newValue: value, color: self?.tranportInfoColor ?? UIColor.black)
        }
    }
    
    func displayConnectionInformation(value: String) {
        DispatchQueue.main.async { [weak self] in
            self?.appendText(newValue: value, color: self?.connectionInfoColor ?? UIColor.black)
        }
    }
    
    func displayDisccoveringInforamtion(value: String) {
//        DispatchQueue.main.async { [weak self] in
//            self?.appendText(newValue: value, color: self?.discoveringInfoColor ?? UIColor.black)
//        }
    }
    
    func displayExtraInformation(value: String) {
//        DispatchQueue.main.async { [weak self] in
//            self?.appendText(newValue: value, color: self?.extraInfoColor ?? UIColor.black)
//        }
    }
    
    
    func didStopManager(value: String) {
        DispatchQueue.main.async { [weak self] in
            self?.appendText(newValue: value, color: self?.connectionInfoColor ?? UIColor.black)
            self?.stateSwitch.setOn(false, animated: true)
            self?.stateLabel.text = "Start Service"
        }
    }
    
    func didStartManager(value: String) {
        DispatchQueue.main.async { [weak self] in
            self?.debugLabel.attributedText = NSAttributedString(string: "")
            self?.errorLabel.text = ""
            self?.appendText(newValue: value, color: self?.connectionInfoColor ?? UIColor.black)
        }
    }
    
    func displayError(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.errorLabel.text = error
            self?.appendText(newValue: error, color: UIColor.red)
        }
    }
    
    func didBluetoothStateChanged(value: String) {
        DispatchQueue.main.async { [weak self] in
            self?.appendText(newValue: value, color: self?.connectionInfoColor ?? UIColor.black)
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
