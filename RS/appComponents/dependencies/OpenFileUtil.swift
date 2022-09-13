//
//  OpenFileUtil.swift
//  RS
//
//  Created by ICoon on 13.09.2022.
//

import Foundation
import UniformTypeIdentifiers
import MobileCoreServices

protocol OpenFileUtilDelegate: NSObject{
    func onError(error: Error)
    func onImportFile(file: Data)
}

public final class OpenFileUtil: NSObject{
    
    
    
    private let documentPicker: UIDocumentPickerViewController
    
    weak var delegate: OpenFileUtilDelegate?
    
    
    func startPicker(view: UIViewController){
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .overFullScreen
        
        view.present(documentPicker, animated: true)
    }
    
    
    override init(){
        if #available(iOS 14, *) {
            // iOS 14 & later
            let supportedTypes: [UTType] = [UTType.json]
            documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes)
        } else {
            // iOS 13 or older code
            let supportedTypes: [String] = [kUTTypeJSON as String]
            documentPicker = UIDocumentPickerViewController(documentTypes: supportedTypes, in: .import)
        }
    }
   
    
    
    
}

@available(iOS 14.0, *)
extension OpenFileUtil : UIDocumentPickerDelegate{
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        
        // Start accessing a security-scoped resource.
        guard url.startAccessingSecurityScopedResource() else {
            self.delegate?.onError(
                error: NSError(domain: #function, code: -1, userInfo: [
                NSLocalizedDescriptionKey:  "enable start acessing file"
                ]))
            return
        }
        
        do {
            let data = try Data.init(contentsOf: url)
            self.delegate?.onImportFile(file: data)
        }
        catch {
            self.delegate?.onError(error: error)
        }
        
        // Make sure you release the security-scoped resource when you finish.
        do { url.stopAccessingSecurityScopedResource() }
        
    }
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true)
    }
}

