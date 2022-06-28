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
    
    var reuseIdentifier: String { get }
}

protocol SettingCell: UITableViewCell {
    func update(with model: SettingsModel)
}


final class SettingsDataSourse : NSObject, UITableViewDataSource, UITableViewDelegate{
    
    
    private var data: [SettingsModel] = []
    
    func setData(data: [SettingsModel]){
        self.data = data
    }
    
    func getSettingsHeaderIdentifier() -> String{
        return String(describing: SettingsHeaderCell.self)
    }
    
    func getSettingsSoundEnableIdentifier() -> String{
        return String(describing: SettingsSoundEnableCell.self)
    }
    
    func getSettingsVolumeIdentifier() -> String{
        return String(describing: SettingsVolumeCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let model = data[indexPath.row]
        let id = model.reuseIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)  as! SettingCell
            cell.update(with: model)
            cell.modify()

            return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    
}
