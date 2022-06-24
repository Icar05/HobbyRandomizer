//
//  DisplayDataSource.swift
//  RS
//
//  Created by ICoon on 24.06.2022.
//

import Foundation

class DisplayDataSource : NSObject, UITableViewDataSource, UITableViewDelegate{
    
    
    private var dataSourse: [RandItemCellModel] = []
    
    
    func getData() -> [RandItemCellModel]{
        return self.dataSourse
    }
    
    func setData(data: [RandItemCellModel]){
        self.dataSourse = data
    }
    
    func getRandCellIdentifier() -> String{
        return String(describing: RandItemCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourse.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: getRandCellIdentifier(), for: indexPath) as! RandItemCell
        cell.configure(model: self.dataSourse[indexPath.row])
        cell.modify()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    
}


