//
//  FilesDataSource.swift
//  HobbyRandomizer
//
//  Created by ICoon on 23.06.2022.
//

import Foundation

class FilesDataSource: NSObject, UITableViewDataSource, UITableViewDelegate{
    
    
    private var dataSourse: [DisplayFileCellModel] = []
    
    func setData(data: [DisplayFileCellModel]){
        self.dataSourse = data
    }
    
    func getIdentifier() -> String{
        return String(describing: DisplayFileCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourse.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: getIdentifier(), for: indexPath) as! DisplayFileCell
        cell.configure(model: self.dataSourse[indexPath.row])
        cell.modify()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    
}


