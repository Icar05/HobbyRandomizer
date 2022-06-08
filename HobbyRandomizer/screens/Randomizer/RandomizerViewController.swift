//
//  RandomizerViewController.swift
//  HobbyRandomizer
//
//  Created by ICoon on 09.06.2022.
//

import UIKit

class RandomizerViewController: UIViewController {
    
    
    
    @IBOutlet weak var status: UIImageView!
    
    @IBOutlet weak var randomizer: RandomizerUtil!
    
    @IBOutlet weak var subtitle: PrettyLabel!
    
    @IBOutlet weak var titleLabel: PrettyLabel!
    
    fileprivate var models = [RandItemCellModel]()
    
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(models: [RandItemCellModel]) {
        self.models = models
        super.init(nibName: "RandomizerViewController", bundle: Bundle.main)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.randomizer.delegate = { (model) in
            if(self.models.count > 0){
                let model = self.models[model.index]
                self.titleLabel.labelText = model.title
                self.subtitle.labelText = model.subTitle
                self.status.setImageColor(color: model.getColorForType())
                self.showAlert(model: model)
            }
        }
        
        self.randomizer.setDataSource(count: models.count)
    }
    
}

