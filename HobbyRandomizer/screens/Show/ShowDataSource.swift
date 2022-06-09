//
//  ShowDataSource.swift
//  HobbyRandomizer
//
//  Created by ICoon on 09.06.2022.
//

import Foundation

class ShowDataSource: NSObject, UITableViewDataSource, UITableViewDelegate{
    
    
    
    private var dataSourse: [RandItemCellModel] = []
    
    
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 100
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    
}


