//
//  OpenFilePresenter.swift
//  RS
//
//  Created by ICoon on 13.09.2022.
//

import Foundation


public final class OpenFilePresenter{
    
    
    
    private let openFileProvider = OpenFileProvider()
    
    unowned var view: OpenFileViewController!
    
    public func set(view: OpenFileViewController) {
        self.view = view
    }
    
    
    public func showAllFiles(){
       let files =  self.openFileProvider.readAllFilenames()
        
        for item in files{
            print("Debug: \(item.shortName)")
        }
        
    }
    
}


