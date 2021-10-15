//
//  HobbyCell.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 13.10.2021.
//

import UIKit

class HobbyCell:UITableViewCell{
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var subtitle: UILabel!
    
    
    func setData(data: HobbyModel){
        self.title.text = data.title
        self.subtitle.text = data.description
    }
}
