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
            NotesInstuctionInfoCellModel(
                info: Translations.NotesInstruction.noteInfoTitle,
                data: Translations.NotesInstruction.noteInfoDescription),
            NotesInstuctionInfoCellModel(
                info: Translations.NotesInstruction.noteActionTitle,
                data: Translations.NotesInstruction.noteActionDescription)
        ]
    }
    
}
