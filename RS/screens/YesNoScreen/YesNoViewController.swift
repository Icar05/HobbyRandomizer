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
        
        self.soundUtil = getAppComponent().getSoundUtil(sound: .Click)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.randomizer.delegate = self
        
        self.presenter.viewDidLoad()
    }
    
    func updateViewWithPreferences(appPreferences: AppPrefferencesModel){
        self.randomizer.setPreferences(preferences: appPreferences)
    }
}

extension YesNoViewController: RandomizerUtilDelegate{
    func onDetectSector() {
        self.soundUtil?.play()
    }
    
    func onModelFound(randModel: RandomizerModel) {}
    
}
