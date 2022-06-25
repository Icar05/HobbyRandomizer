//
//  FilesPresenter.swift
//  HobbyRandomizer
//
//  Created by ICoon on 23.06.2022.
//

import Foundation

public final class FilesPresenter{
    
    
    
    private let filesUtil: FileWriterUtil
    
    unowned var view: FilesViewController!
    
    public func set(view: FilesViewController) {
        self.view = view
    }
    
    init(filesUtil: FileWriterUtil){
        self.filesUtil = filesUtil
    }
    
    func viewDidLoad(){
        let data = filesUtil.readAllFilenames()
        self.view.onDataLoaded(data: data)
    }
    
    func parseFileData(fileName: String){
        
        if let models = filesUtil.importModelsAsJson(fileName: fileName){
            view.displayModels(data: models)
            return
        }
        
        if let models = filesUtil.importModelsAsCustom(fileName: fileName){
            view.displayModels(data: models)
            return
        }
        
        let content = filesUtil.readFile(fileName: fileName)
        view.displayText(data: content)
    }
    
    func removeItemByName(fileName: String){
        let result = filesUtil.removeItem(fileName: fileName)
        view.didFileRemoved(value: result)
    }
    
}
