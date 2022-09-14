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
    
    private let importUtil: ImportUtil
    
    @IBOutlet weak var actionButton: UIButton!
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: OpenFilePresenter, alertUtil: AlertUtil, openFileUtil: OpenFileUtil, importUtil: ImportUtil) {
        self.presenter = presenter
        self.alertUtil = alertUtil
        self.openFileUtil = openFileUtil
        self.importUtil = importUtil
        
        super.init(nibName: "OpenFileViewController", bundle: Bundle.main)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.actionButton.setTitle(Translations.Import.buttonLabel, for: .normal)
        self.actionButton.addTarget(self,  action: #selector(buttonAction), for: .touchUpInside)
        self.actionButton.layer.borderColor = UIColor.black.cgColor
        self.actionButton.layer.borderWidth = 1
        self.actionButton.layer.masksToBounds = true
    }
    
    @objc func buttonAction(sender: UIButton!) {
        self.openFileUtil.delegate = self
        self.openFileUtil.startPicker(view: self)
    }
    
}



extension OpenFileViewController: OpenFileUtilDelegate{
    
    
    func onError(error: Error) {
        let alert = self.alertUtil.getAlert(title: Translations.Alert.failure, subtitle: Translations.Alert.readingFileError)
        present(alert, animated: true)
    }
    
    func onImportFile(file: Data) {
        self.importUtil.importData(data: file){ _ in
            self.showSuccessAlert()
        }
    }
    
    
    private func showSuccessAlert(){
        let alert = alertUtil.getAlert(title: Translations.Alert.success, subtitle: Translations.Alert.successImportMessage)
        present(alert, animated: true)
    }

    
}


