//
//  CreateHobbyCell.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 14.10.2021.
//

import UIKit

class CreateHobbyCell :UITableViewCell{
    
    @IBOutlet weak var createHobbyView: CreateIdeaView!
    
    
    func setupDelegate(_ delegate: @escaping Cr){
        self.createHobbyView.delegate = delegate
    }

}
