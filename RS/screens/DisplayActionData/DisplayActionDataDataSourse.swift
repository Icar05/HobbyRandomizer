//
//  DisplayActionDataDataSourse.swift
//  RS
//
//  Created by ICoon on 26.06.2022.
//

import Foundation

protocol DisplayActionSourceDelegate: NSObject{
    func didImportClick()
}

class DisplayActionDataDataSourse : NSObject, UITableViewDataSource, UITableViewDelegate{
    
    
    
    private var data: [RandItemCellModel] = []
    
    weak var delegate: DisplayActionSourceDelegate? = nil
    
    
    
    func getData() -> [RandItemCellModel]{
        return self.data
    }
    
    func setData(data: [RandItemCellModel]){
        self.data = data
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
            cell.modify()
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: getRandCellIdentifier(), for: indexPath) as! RandItemCell
        cell.configure(model: self.data[indexPath.row - 1])
        cell.modify()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0){
            self.delegate?.didImportClick()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    
}

