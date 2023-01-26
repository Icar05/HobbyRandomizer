//
//  RandomReportDataSource.swift
//  RS
//
//  Created by Галяткин Александр on 26.01.2023.
//

import Foundation


protocol ReportModel{
    var reuseIdentifier: String { get }
}

protocol ReportCell: UITableViewCell {
    func update(with model: ReportModel)
}


final class RandomReportDataSource : NSObject, UITableViewDataSource, UITableViewDelegate{
    
    
    private var data: [ReportModel] = []
    
    func setData(data: [ReportModel]){
        self.data = data
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let model = data[indexPath.row]
        let id = model.reuseIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)  as! ReportCell
            cell.update(with: model)
            cell.modify()

            return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    
}
