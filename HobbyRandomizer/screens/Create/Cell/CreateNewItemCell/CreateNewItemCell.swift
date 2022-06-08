//
//  CreateNewItemCell.swift
//  HobbyRandomizer
//
//  Created by ICoon on 08.06.2022.
//

import UIKit

class CreateNewItemCell: UITableViewCell {

    
    @IBOutlet weak var createIdeaView: CreateIdeaView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setupDelegate(delegate: CreateViewDelegate){
        self.createIdeaView.delegate = delegate
    }
    
}
