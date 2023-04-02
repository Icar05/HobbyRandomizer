//
//  InitialViewController.swift
//  HobbyRandomizer
//
//  Created by ICoon on 07.06.2022.
//

import UIKit

public final class InitialViewController: UINavigationController {
    
    
    
    private var isStartedFromInitial = true
    
    private var soundUtil: SoundUtil?
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        self.soundUtil = getAppComponent().getSoundUtil(sound: SoundCaf.transitionSound())
        self.delegate = self
        
    }
    
    func reLoadSound(){
        self.soundUtil = getAppComponent().getSoundUtil(sound: SoundCaf.transitionSound())
    }
    
    private func setupUI() {}
    
}

extension InitialViewController: UINavigationControllerDelegate{
    
    /**
     Called just before the navigation controller displays a view controller’s view and navigation item properties.
     */
    public func navigationController(_: UINavigationController, willShow: UIViewController, animated: Bool){
        if(isStartedFromInitial){
            self.isStartedFromInitial = false
        }else{
            self.soundUtil?.play()
        }
    }
    
    
}
