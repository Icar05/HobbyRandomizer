//
//  RandomizerViewController.swift
//  HobbyRandomizer
//
//  Created by ICoon on 09.06.2022.
//

import UIKit

class RandomizerViewController: UIViewController {
    
    
    
    fileprivate var models = [RandItemCellModel]()
    
    @IBOutlet weak var status: UIImageView!
    
    @IBOutlet weak var randomizer: RandomizerUtil!
    
    @IBOutlet weak var subtitle: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    
   
    
    
    
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
        
        self.setupText()
        self.randomizer.delegate = { (randModel) in
            if(self.models.count > 0){
                let model = self.models[randModel.index]
                self.titleLabel.text = model.title
                self.titleLabel.textColor = randModel.color
                self.subtitle.text = model.subTitle
                self.status.setImageColor(color: randModel.color )
                self.icon.setImageColor(color: model.type.getColorForType())
                self.showAlert(model: model)
            }
        }
        
        self.randomizer.setDataSource(count: models.count)
    }
    
    private func setupText(){
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor.black,
            .foregroundColor: UIColor.white,
            .strokeWidth: -3.0
        ]
        self.titleLabel.attributedText = NSAttributedString(string: "Title", attributes: strokeTextAttributes)
    }
    
}

