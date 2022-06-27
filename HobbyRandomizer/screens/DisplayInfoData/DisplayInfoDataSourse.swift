//
//  DisplayInfoDataDataSourse.swift
//  RS
//
//  Created by ICoon on 26.06.2022.
//

import Foundation

protocol DisplayInfoDelegate: NSObject{
    func onCollapsed(indexPath: [IndexPath])
    func onExpanded(indexPath: [IndexPath])
}

class DisplayInfoDataSource: NSObject, UITableViewDataSource, UITableViewDelegate{
    
    
    
    private var hiddenSections = Set<Int>()
    
    private var data: [DisplayInfoModel] = []
    
    weak var delegate: DisplayInfoDelegate? = nil
    
    
    func setData(data: [DisplayInfoModel]){
        self.data = data
    }
    
    func getCathegoryCellIdentifier() -> String{
        return String(describing: CathegoryCell.self)
    }
    
    func getInfoDetailCellIdentifier() -> String{
        return String(describing: InfoDetailCell.self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.hiddenSections.contains(section) {
            return 0
        }

        return data[section].content.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headercell = HeaderCell()
        headercell.text = data[section].title
        headercell.callback = {
            self.sectionDidClick(section: section)
        }
        
        return headercell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46
    }
    
    private func sectionDidClick(section: Int){
        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
            self.delegate?.onExpanded(indexPath: indexPathsForSection(section: section))
        } else {
            self.hiddenSections.insert(section)
            self.delegate?.onCollapsed(indexPath: indexPathsForSection(section: section))
        }
    }
    
    func indexPathsForSection(section: Int) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        
        for row in 0...self.data[section].content.count - 1{
            indexPaths.append(IndexPath(row: row, section: section))
        }
        

        return indexPaths
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = data[indexPath.section].content[indexPath.row]
        
        if(model.isCathegory){
            let cell = tableView.dequeueReusableCell(withIdentifier: getCathegoryCellIdentifier(), for: indexPath) as! CathegoryCell
            cell.configure(value: model.title)
            cell.modify()
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: getInfoDetailCellIdentifier(), for: indexPath) as! InfoDetailCell
        cell.configure(value: model.title)
        cell.modify()
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    
}

