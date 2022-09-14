//
//  FilesDetailPresenter.swift
//  RS
//
//  Created by ICoon on 11.09.2022.
//

import Foundation

public final class FilesDetailPresenter{
    
    
    
    private let filesUtil: FileWriterUtil
    
    private let jsonDecoder: JsonDecoder
    
    private let folderName: String
    
    unowned var view: FilesDetailViewController!
    
    public func set(view: FilesDetailViewController) {
        self.view = view
    }
    
    init(filesUtil: FileWriterUtil, folderName: String, jsonDecoder: JsonDecoder){
        self.filesUtil = filesUtil
        self.folderName = folderName
        self.jsonDecoder = jsonDecoder
    }
    
    func viewDidLoad(){
        let data = filesUtil.readAllFileNamesInFolder(folderName: folderName)
        self.view.onDataLoaded(data: data)
    }
    
    func parseFileData(file: FileDetailCellModel){
        
        
        guard let data = filesUtil.readFile(fileName: file.fileName, dirName: file.folderName).data(using: .utf8) else {
            print("enable to parse data")
            return
        }

        
        switch file.folderName{
            
            case FolderName.Info.rawValue :
            self.handleInfo(data: data)
                break
                
            case FolderName.Action.rawValue :
            self.handleAction(data: data)
                break
                
            case FolderName.Play.rawValue :
            self.handlePlay(data: data)
                break
            
            default:
                break
        }
        
    }
    
    private func handlePlay(data: Data){
        guard let models: [String] = jsonDecoder.decode(data: data, type: [String].self) else {
            return
        }
        
        self.view.displayData(data: models)
    }
    
    private func handleAction(data: Data){
        guard let models: [ActionModel] = jsonDecoder.decode(data: data, type: [ActionModel].self) else {
            return
        }
        
        self.view.displayData(data: models)
    }
    
    private func handleInfo(data: Data){
        guard let models: [InfoModel] = jsonDecoder.decode(data: data, type: [InfoModel].self) else {
            return
        }
        
        self.view.displayData(data: models)
    }
    
}
