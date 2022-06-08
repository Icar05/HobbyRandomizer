//
//  NavigatorImpl.swift
//  HobbyRandomizer
//
//  Created by ICoon on 07.06.2022.
//

import Foundation

class NavigatorImpl: Navigator{
    
    
    
    
    
    
    func setupInitialViewController(window: UIWindow) {
        window.rootViewController = getInitialController()
        window.makeKeyAndVisible()
    }
    
    func getInitialController() -> InitialViewController{
        let navVc = InitialViewController()
        let menuVc = getMenuScreen()
            navVc.viewControllers = [menuVc]
        return navVc
    }
    
    func navigate(start: UIViewController, destination: UIViewController){
        start.navigationController?.pushViewController(destination, animated: true)
    }
    
    func getMenuScreen() -> UIViewController {
        let presenter = MenuPresenter()
        let viewController = MenuViewController(presener: presenter)
            presenter.set(view: viewController)
        
        return viewController
    }
    
    
    func getCasinoScreen() -> UIViewController {
        let viewcontroller = CasinoViewController()
        return viewcontroller
    }
    
}
