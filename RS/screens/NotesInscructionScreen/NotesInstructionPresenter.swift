//
//  NotesInstructionPresenter.swift
//  RS
//
//  Created by ICoon on 29.06.2022.
//

import Foundation

public final class NotesInstructionPresenter{
    
    
    
    unowned var view: NotesInstructionViewController!
    
    public func set(view: NotesInstructionViewController) {
        self.view = view
    }
    
    func viewDidLoad(){
        let content = getModels()
        self.view.onDataLoaded(data: content)
    }

    private func getModels() -> [NotesInstuctionInfoCellModel]{
        return [
            NotesInstuctionInfoCellModel(info: "How to create info", type: .info),
            NotesInstuctionInfoCellModel(info: "How to create action", type: .action)
        ]
    }
    
}
