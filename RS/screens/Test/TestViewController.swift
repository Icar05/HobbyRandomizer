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
    
    private var text = ""
    
    private var errorText = ""
    
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
            self?.text += "\n"
            self?.text += value
            self?.debugLabel.text = self?.text ?? ""
        }
    }
    
    func displayConnectionInformation(value: String) {
        DispatchQueue.main.async { [weak self] in
            self?.text += "\n"
            self?.text += value
            self?.debugLabel.text = self?.text ?? ""
        }
    }
    
    func displayDisccoveringInforamtion(value: String) {
        DispatchQueue.main.async { [weak self] in
            self?.text += "\n"
            self?.text += value
            self?.debugLabel.text = self?.text ?? ""
        }
    }
    
    func displayExtraInformation(value: String) {
        DispatchQueue.main.async { [weak self] in
            self?.text += "\n"
            self?.text += value
            self?.debugLabel.text = self?.text ?? ""
        }
    }
    
    
    func didStopManager(value: String) {
        DispatchQueue.main.async { [weak self] in
            self?.text += "\n"
            self?.text += value
            self?.debugLabel.text = self?.text
            self?.stateSwitch.setOn(false, animated: true)
            self?.stateLabel.text = "Start Service"
        }
    }
    
    func didStartManager(value: String) {
        DispatchQueue.main.async { [weak self] in
            self?.text = ""
            self?.errorText = ""
            self?.text += "\n"
            self?.text += value
            self?.errorLabel.text = ""
            self?.debugLabel.text = self?.text
        }
    }
    
    func displayError(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.errorText += "\n"
            self?.errorText += error
            self?.errorLabel.text = self?.errorText ?? ""
        }
    }
    
    func didBluetoothStateChanged(value: String) {
        DispatchQueue.main.async { [weak self] in
            self?.text += "\n"
            self?.text += value
            self?.debugLabel.text = self?.text ?? ""
        }
    }
    
}
