//
//  DisplayRawDataDataSourse.swift
//  RS
//
//  Created by ICoon on 26.06.2022.
//

import Foundation


final class DisplayRawDataDataSourse: NSObject, UITableViewDataSource, UITableViewDelegate{
    
    
    private var data: String = ""
    
    
    func setData(data: String){
        self.data = data
    }
    
    func getIdentifier() -> String{
        return String(describing: DisplayRawDataCell.self)
    }
    
    func getImportCellIdentifier() -> String{
        return String(describing: ImportDataCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: getIdentifier(), for: indexPath) as! DisplayRawDataCell
        cell.configure(model: DisplayRawDataCellModel(data: data))
        cell.modify()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    
}
