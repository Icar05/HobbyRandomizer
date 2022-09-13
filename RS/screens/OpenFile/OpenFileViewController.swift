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
    
    @IBAction func actionClick(_ sender: Any) {
        self.openDocumentPicker()
    }
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: OpenFilePresenter) {
        self.presenter = presenter
        
        super.init(nibName: "OpenFileViewController", bundle: Bundle.main)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func openDocumentPicker() {
        let documentPicker: UIDocumentPickerViewController
        
        if #available(iOS 14, *) {
            // iOS 14 & later
            let supportedTypes: [UTType] = [UTType.text, UTType.json, UTType.folder]
            documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes)
        } else {
            // iOS 13 or older code
            let supportedTypes: [String] = [
                kUTTypeText as String,
                kUTTypeJSON as String,
                kUTTypeFolder as String]
            documentPicker = UIDocumentPickerViewController(documentTypes: supportedTypes, in: .import)
        }
        
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .overFullScreen
        present(documentPicker, animated: true)
    }
    
}


@available(iOS 14.0, *)
extension OpenFileViewController : UIDocumentPickerDelegate{
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        
        // Start accessing a security-scoped resource.
        guard url.startAccessingSecurityScopedResource() else {
            // Handle the failure here.
            return
        }
        
        do {
            let data = try Data.init(contentsOf: url)
            // You will have data of the selected file
            
            let string = String(data: data, encoding: .utf8)
            
            print(string)
            
        }
        catch {
            print(error.localizedDescription)
        }
        
        // Make sure you release the security-scoped resource when you finish.
        do { url.stopAccessingSecurityScopedResource() }
        
    }
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        self.dismiss(animated: true)
    }
}
