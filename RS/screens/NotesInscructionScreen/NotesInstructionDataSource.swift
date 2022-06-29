//
//  NotesInstructionDataSource.swift
//  RS
//
//  Created by ICoon on 29.06.2022.
//


import Foundation

enum NotesType{
    case action, info
}

protocol NotesInstructionDelegate: NSObject{
    func howToCreateNote(model: NotesInstuctionInfoCellModel)
}

class NotesInstructionDataSource: NSObject, UITableViewDataSource, UITableViewDelegate{
    
    
    private var data: [NotesInstuctionInfoCellModel] = []
    
    weak var delegate: NotesInstructionDelegate? = nil
    
    func setData(data: [NotesInstuctionInfoCellModel]){
        self.data = data
    }
    
    func getNoteInstructionCellId() -> String{
        return String(describing: NotesInstructionInfoCell.self)
    }
    
    func getNoteInstructionHeaderCellId() -> String{
        return String(describing: NotesInstuctionHeaderCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count + 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: getNoteInstructionHeaderCellId(), for: indexPath) as! NotesInstuctionHeaderCell
            cell.configure(model: NotesInstructionHeaderCellModel(info: "Some info"))
            cell.modify()
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: getNoteInstructionCellId(), for: indexPath) as! NotesInstructionInfoCell
        cell.configure(model: self.data[indexPath.row - 1])
        cell.modify()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row > 0){
            let model = self.data[indexPath.row - 1]
            self.delegate?.howToCreateNote(model: model)
        }
    }
    
}


