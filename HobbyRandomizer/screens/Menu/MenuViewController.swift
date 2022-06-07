//
//  MenuViewController.swift
//  HobbyRandomizer
//
//  Created by ICoon on 07.06.2022.
//

import UIKit

public final class MenuViewController: UIViewController {
    
    private let presenter: MenuPresenter
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presener: MenuPresenter) {
        self.presenter = presener
        
        super.init(nibName: "MenuViewController", bundle: Bundle.main)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    
    
}
