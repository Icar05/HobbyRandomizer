//
//  RandomViewController.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 13.10.2021.
//

import UIKit

class RandomViewController: UIViewController {
    
    
    fileprivate let viewModel = MainViewModel.shared
    
    @IBOutlet weak var randomizer: RandomizerUtil!
    
    @IBOutlet weak var subtitle: PrettyLabel!
    
    @IBOutlet weak var titleLabel: PrettyLabel!
    
    fileprivate var content = [HobbyModel]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.randomizer.delegate = { (value) in
            if(self.content.count > 0){
                let model = self.content[value]
                self.titleLabel.labelText = model.title
                self.subtitle.labelText = model.description
                self.showAlert(model: model)
            }
        }
        
        
        let content = self.viewModel.getModels()
        if(content != nil){
            self.randomizer.setDataSource(count: content!.count)
            self.content = content!
        }
        
    }

}
