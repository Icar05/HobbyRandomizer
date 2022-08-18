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
        self.debugLabel.text = "Here will be text"
    }
    
    @objc func switchChanged(mySwitch: UISwitch) {
        self.stateLabel.text = mySwitch.isOn ?  "Stop servise" : "Start Service"
        mySwitch.isOn ?  client.startBLEApi() : client.stopBLEApi()
    }

}

extension TestViewController: BLEApiListener{
    
    func didStopManager() {
//        self.debugLabel.text = "didStopManager"
        self.stateSwitch.setOn(false, animated: true)
    }
    
    func didStartManager() {
        self.debugLabel.text = "didStartManager"
    }
    
    func didError(error: String) {
        self.errorLabel.text = error
    }
    
    func didBluetoothStateChanged(isEnabled: Bool) {
        self.debugLabel.text = "didBluetoothStateChanged: \(isEnabled)"
    }
    
    func didNotified(value: String) {
        self.debugLabel.text = value
    }
    
    
}
