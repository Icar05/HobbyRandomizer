//
//  YesNoViewController.swift
//  RS
//
//  Created by ICoon on 30.06.2022.
//

import UIKit

public final class YesNoViewController: UIViewController {
    
    
    
    private let presenter: YesNoPresenter
    
    private var soundUtil: SoundUtil? = nil
    
    @IBOutlet weak var randomizer: YesNoUtil!
    
    @IBOutlet weak var backgroundView: UIView!
    
    
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: YesNoPresenter) {
        self.presenter = presenter
        
        super.init(nibName: "YesNoViewController", bundle: Bundle.main)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.soundUtil = getPlayer(sound: .Tink)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.randomizer.delegate = self
        self.setGradientBackground()
        
        self.presenter.viewDidLoad()
    }
    
    func updateViewWithPreferences(appPreferences: AppPrefferencesModel){
        self.randomizer.setPreferences(preferences: appPreferences)
    }
    
    private func setGradientBackground() {
        
        guard let top = UIColor.coolRed?.cgColor,
              let mid = UIColor.coolOrange?.cgColor,
              let bot = UIColor.coolGreen?.cgColor
        else {
            return
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [top, mid, bot]
        gradientLayer.locations = [0.1, 0.5, 1.0]
        gradientLayer.frame = backgroundView.bounds
        
        backgroundView.layer.insertSublayer(gradientLayer, at:0)
    }
}

extension YesNoViewController: RandomizerUtilDelegate{
    func onDetectSector() {
        self.soundUtil?.play()
    }
    
    func onModelFound(randModel: RandomizerModel) {}
    
}
