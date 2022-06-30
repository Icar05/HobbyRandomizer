//
//  SelectColorsDataSource.swift
//  RS
//
//  Created by ICoon on 29.06.2022.
//

import Foundation

struct SelectColorModel{
    var type: SelectType
    var color: Color
}

enum SelectType{
    case YES, NO
}

extension SelectType{
    func getTitle() -> String{
        if(self == .YES){
            return Translations.SelectColor.yes
        }else{
            return Translations.SelectColor.no
        }
    }
}

protocol SelectColorsDelegate : ExpandableDelegate{
    func didColorChange(type: SelectType, color: Color)
}

class SelectColorsDataSourse:  NSObject, UITableViewDataSource, UITableViewDelegate{
    
    
    
    private var hiddenSections = Set<Int>()
    
    private var data: [SelectColorModel] = []
    
    weak var delegate: SelectColorsDelegate? = nil
    
    
    func getIdentifier() -> String{
        return String(describing: SelectColorCell.self)
    }
    
    
    func setData(data: [SelectColorModel]){
        self.data = data
        self.hideContent()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.hiddenSections.contains(section) {
            return 0
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let model = data[section]
        let headercell = HeaderCell()
        
        headercell.text = "\(Translations.SelectColor.selectColorTitle) \(model.type.getTitle())"
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
        return [IndexPath(row: 0, section: section)]
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = self.data[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: getIdentifier(), for: indexPath) as! SelectColorCell
            cell.configure(model: SelectColorCellModel(
                type: model.type,
                color: model.color,
                callback: {item, color  in
                    self.delegate?.didColorChange(type: item, color: color)
                }))
            cell.modify()
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    
    
    private func hideContent(){
        for i in 0...data.count - 1{
            hiddenSections.insert(i)
        }
    }
    
}


