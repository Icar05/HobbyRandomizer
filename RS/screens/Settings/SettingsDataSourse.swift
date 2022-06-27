//
//  SettingsDataSourse.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import Foundation

protocol SettingsModel{
    func isHeader() -> Bool
    func getTitle() -> String
}

final class SettingsDataSourse : NSObject, UITableViewDataSource, UITableViewDelegate{
    
    
    private let data: [SettingsModel] = [
        SettingsHeaderCellModel(title: "Sound"),
        SettingsHeaderCellModel(title: "Test"),
    ]
    
    func getSettingsHeaderIdentifier() -> String{
        return String(describing: SettingsHeaderCell.self)
    }
    
    func getImportCellIdentifier() -> String{
        return String(describing: ImportDataCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = data[indexPath.row]
        
        if(model is SettingsHeaderCellModel){
            let cell = tableView.dequeueReusableCell(withIdentifier: getSettingsHeaderIdentifier(), for: indexPath) as! SettingsHeaderCell
            cell.configure(model: model as! SettingsHeaderCellModel)
            cell.modify()
            return cell
        }
        
        let cell = UITableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    
}
