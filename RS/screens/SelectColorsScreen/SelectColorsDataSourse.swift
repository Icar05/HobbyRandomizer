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

protocol SelectColorsDelegate : NSObject{
    func didColorChange(type: SelectType, color: Color)
}

class SelectColorsDataSourse:  NSObject, UITableViewDataSource, UITableViewDelegate{
    
    
    
    private var data: [SelectColorModel] = []
    
    weak var delegate: SelectColorsDelegate? = nil
    
    
    func setData(data: [SelectColorModel]){
        self.data = data
    }
    
    func getIdentifier() -> String{
        return String(describing: SelectColorCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = self.data[indexPath.row]
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
    
}
