//
//  CreateViewDataSource.swift
//  HobbyRandomizer
//
//  Created by ICoon on 08.06.2022.
//

import Foundation

protocol CreateDataSourceDelegate: NSObject{
    func onModelCreated(freshModels: [RandItemCellModel])
    func onModelDeleted(freshModels: [RandItemCellModel])
    func onClearDatatDidTap(indexPath: [IndexPath])
}

class CreateViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, CreateViewDelegate {
    
    
    
    private var data: [RandItemCellModel] = []
    
    weak var delegate: CreateDataSourceDelegate? = nil
    
    
    func setData(data: [RandItemCellModel]){
        self.data = data
    }
    
    func getRandCellIdentifier() -> String{
        return String(describing: RandItemCell.self)
    }
    
    func getCreateItemCellIdentifier() -> String{
        return String(describing: CreateNewItemCell.self)
    }
    
    func getExportCellIndifier() -> String{
        return String(describing: ActionButtonCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: getCreateItemCellIdentifier(), for: indexPath) as! CreateNewItemCell
            cell.modify()
            cell.setupDelegate(delegate: self)
            
            return cell
        }else if( indexPath.row == data.count + 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: getExportCellIndifier(), for: indexPath) as! ActionButtonCell
            cell.modify()
            cell.setupDelegate(callback: {
                let indexesCount = self.data.count
                self.data.removeAll()
                self.delegate?.onClearDatatDidTap(indexPath: self.prepareIndexes(indexesCount: indexesCount))
            })
            
            cell.isHidden = self.data.count < 1
            return cell
        } else{
            let cell = tableView.dequeueReusableCell(withIdentifier: getRandCellIdentifier(), for: indexPath) as! RandItemCell
            cell.configure(model: self.data[indexPath.row - 1])
            cell.modify()
            return cell
        }
        
    }
    
    private func prepareIndexes(indexesCount: Int) -> [IndexPath]{
        return [Int](1...indexesCount).map { IndexPath(row: $0, section: 0)}
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if(indexPath.row == 0 || indexPath.row > data.count){
            return UITableViewCell.EditingStyle.none
        }
        
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete && indexPath.row > 0 && indexPath.row <= data.count {
            self.data.remove(at: indexPath.row - 1)
            self.delegate?.onModelDeleted(freshModels: self.data)
        }
    }
    
    func onItemCreated(item: RandItemCellModel) {
        self.data.append(item)
        self.delegate?.onModelCreated(freshModels: self.data)
    }
    
    
}
