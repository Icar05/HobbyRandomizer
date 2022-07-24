//
//  ShowDataSource.swift
//  HobbyRandomizer
//
//  Created by ICoon on 09.06.2022.
//

import Foundation

protocol ShowDataSourceDelegate: NSObject{
    func startRandomDidClick()
}

class ShowDataSource: NSObject, UITableViewDataSource, UITableViewDelegate{
    
    
    private var data: [RandItemCellModel] = []
    
    private var type: ItemType = ItemType.HardDayNight
    
    weak var delegate: ShowDataSourceDelegate? = nil
    
    
    
    func getData() -> [RandItemCellModel]{
        return self.data
    }
    
    func setType(type: ItemType){
        self.type = type
    }
    
    func setData(data: [RandItemCellModel]){
        self.data = data
    }
    
    func getRandCellIdentifier() -> String{
        return String(describing: RandItemCell.self)
    }
    
    func getTopCellIdentifier() -> String{
        return String(describing: TopCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count + 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: getTopCellIdentifier(), for: indexPath) as! TopCell
            cell.configure(model: self.type){
                self.delegate?.startRandomDidClick()
            }
            cell.modify()
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: getRandCellIdentifier(), for: indexPath) as! RandItemCell
        cell.configure(model: self.data[indexPath.row - 1])
        cell.modify()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    
}


