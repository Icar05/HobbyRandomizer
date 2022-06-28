//
//  RandomizerViewController.swift
//  HobbyRandomizer
//
//  Created by ICoon on 09.06.2022.
//

import UIKit

public final class RandomizerViewController: UIViewController {
    
    
    
    private let presenter: RandomizerViewPresenter
    
    fileprivate var models = [RandItemCellModel]()
    
    @IBOutlet weak var status: UIImageView!
    
    @IBOutlet weak var randomizer: RandomizerUtil!
    
    @IBOutlet weak var subtitle: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(models: [RandItemCellModel], presenter: RandomizerViewPresenter) {
        self.presenter = presenter
        self.models = models
        
        super.init(nibName: "RandomizerViewController", bundle: Bundle.main)
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupText()
        self.titleLabel.text = Translations.Random.selectedTitle
        self.subtitle.text = Translations.Random.selectedDescription
        
        self.randomizer.delegate = self
        
        let type: ItemType = models.first?.type ?? ItemType.necessary
        self.randomizer.setBangButtonBackgroundColor(color: type.getColorForTypeInversed())
        self.scrollView.backgroundColor = type.getColorForType()
        self.randomizer.setDataSource(count: models.count)
        
        presenter.viewDidLoad()
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

extension RandomizerViewController: RandomizerUtilDelegate{
    func onDetectSector() {
        presenter.play()
    }
    
    func onModelFound(randModel: RandomizerModel) {
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
    
    
}

