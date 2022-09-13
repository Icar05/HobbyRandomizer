//
//  FilesDetailPresenter.swift
//  RS
//
//  Created by ICoon on 11.09.2022.
//

import Foundation

public final class FilesDetailPresenter{
    
    
    
    private let filesUtil: FileWriterUtil
    
    private let folderName: String
    
    unowned var view: FilesDetailViewController!
    
    public func set(view: FilesDetailViewController) {
        self.view = view
    }
    
    init(filesUtil: FileWriterUtil, folderName: String){
        self.filesUtil = filesUtil
        self.folderName = folderName
    }
    
    func viewDidLoad(){
        let data = filesUtil.readAllFileNamesInFolder(folderName: folderName)
        self.view.onDataLoaded(data: data)
    }
    
    func parseFileData(fileName: String){
        
        let result: Any  = filesUtil.importModels(fileName: fileName) as Any
    
        if(result is [ActionModel]){
            view.displayData(data: result as! [ActionModel])
            return
        }
        
        
        if(result is [InfoModel]){
            view.displayData(data: result as! [InfoModel])
            return
        }
        
        if(result is String){
            view.displayData(data: result as! String)
        }
        
        return
        
    }
    
}
