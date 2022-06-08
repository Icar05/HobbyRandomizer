//
//  CreateViewDataSource.swift
//  HobbyRandomizer
//
//  Created by ICoon on 08.06.2022.
//

import Foundation

class CreateViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    
    private var dataSourse: [RandItemCellModel] = []
    
    weak var delegate: CreateViewDelegate? = nil
    
    
    func setData(data: [RandItemCellModel]){
        self.dataSourse = data
    }
    
    func getRandCellIdentifier() -> String{
        return String(describing: RandItemCell.self)
    }
    
    
    func getCreateItemCellIdentifier() -> String{
        return String(describing: CreateNewItemCell.self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourse.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: getCreateItemCellIdentifier(), for: indexPath) as! CreateNewItemCell
            cell.modify()
            #warning("todo set delegate")
            //            cell.setupDelegate{ (model) in self.onModelCreated(model: model)}
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: getRandCellIdentifier(), for: indexPath) as! RandItemCell
        cell.configure(model: self.dataSourse[indexPath.row - 1])
        cell.modify()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return indexPath.row == 0 ? 170: 70
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return indexPath.row == 0 ? UITableViewCell.EditingStyle.none : UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete && indexPath.row > 0 {
            #warning("todo on remove")
//            self.dataSourse.remove(at: indexPath.row - 1)
//            self.presenter.saveModels(models: self.datasource)
//            tableView.reloadData()
        }
    }
    
}
