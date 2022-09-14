//
//  DisplayActionDataDataSourse.swift
//  RS
//
//  Created by ICoon on 26.06.2022.
//

import Foundation

protocol DisplayActionSourceDelegate: NSObject{
    func didImportClick(indexPases: [IndexPath])
    func didRandomClick()
}

class DisplayActionDataDataSourse : NSObject, UITableViewDataSource, UITableViewDelegate{
    
    
    
    private var data: [ActionModel] = []
    
    weak var delegate: DisplayActionSourceDelegate? = nil
    
    
    
    func getData() -> [ActionModel]{
        return self.data
    }
    
    func setData(data: [ActionModel]){
        self.data = data
    }
    
    
    func clearData(){
        self.data = []
    }
    
    func getRandCellIdentifier() -> String{
        return String(describing: RandItemCell.self)
    }
    
    func getImportCellIdentifier() -> String{
        return String(describing: ImportDataCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count + 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: getImportCellIdentifier(), for: indexPath) as! ImportDataCell
            cell.configure(model: getImportModel())
            cell.modify()
            cell.isHidden = data.count == 0
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: getRandCellIdentifier(), for: indexPath) as! RandItemCell
        cell.configure(model: self.data[indexPath.row - 1])
        cell.modify()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0){
            needImport() ? self.delegate?.didImportClick(indexPases: prepareIndexes(indexesCount: self.data.count)) : self.delegate?.didRandomClick()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    
    private func getImportModel() -> ImportDataCellModel{
        let title = needImport() ? Translations.DisplayData.makeImport: Translations.Random.play
        return ImportDataCellModel(title: title)
    }
    
    private func needImport() -> Bool{
        return data.first?.type != .Random
    }
    
    private func prepareIndexes(indexesCount: Int) -> [IndexPath]{
        return [Int](1...indexesCount).map { IndexPath(row: $0, section: 0)}
    }
    
}

