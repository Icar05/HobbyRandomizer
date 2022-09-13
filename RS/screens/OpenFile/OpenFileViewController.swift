//
//  OpenFileViewController.swift
//  RS
//
//  Created by ICoon on 11.09.2022.
//

import UIKit
import UniformTypeIdentifiers
import MobileCoreServices


public final class OpenFileViewController: UIViewController {
    
    
    
    
    private let presenter: OpenFilePresenter
    
    private let openFileUtil: OpenFileUtil
    
    private let alertUtil: AlertUtil
    
    @IBOutlet weak var actionButton: UIButton!
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: OpenFilePresenter, alertUtil: AlertUtil, openFileUtil: OpenFileUtil) {
        self.presenter = presenter
        self.alertUtil = alertUtil
        self.openFileUtil = openFileUtil
        
        super.init(nibName: "OpenFileViewController", bundle: Bundle.main)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.actionButton.setTitle("Open file", for: .normal)
        self.actionButton.addTarget(self,  action: #selector(buttonAction), for: .touchUpInside)

    }
    
    @objc func buttonAction(sender: UIButton!) {
        self.openFileUtil.delegate = self
        self.openFileUtil.startPicker(view: self)
    }

}

extension OpenFileViewController: OpenFileUtilDelegate{
    func onError(error: Error) {
        let alert = self.alertUtil.getAlert(title: "Error", subtitle: "Error while reading file!")
        present(alert, animated: true)
    }
    
    func onImportFile(file: Data) {
        let string = String(data: file, encoding: .utf8)
        print(string)
    }
    
    
}


