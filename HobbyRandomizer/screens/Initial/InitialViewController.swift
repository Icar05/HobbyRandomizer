//
//  InitialViewController.swift
//  HobbyRandomizer
//
//  Created by ICoon on 07.06.2022.
//

import UIKit

public final class InitialViewController: UINavigationController {
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
//        setNavigationBarHidden(true, animated: false)
//        navigationBar.barStyle = .black
//        interactivePopGestureRecognizer?.delegate = self
    }
}
