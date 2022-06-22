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
        
        guard let models = filesUtil.importModels(fileName: fileName) else{
            let content = filesUtil.readFile(fileName: fileName)
            view.displayText(data: content)
            return
        }
       
        view.displayModels(data: models)
    }
    
}
