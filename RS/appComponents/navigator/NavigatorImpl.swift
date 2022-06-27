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
    
    func getDebugScreen() -> UIViewController {
        let viewcontroller = DebugViewController()
        return viewcontroller
    }
    
    func getCreateScreen(storage: UserDefaultStorage, fileUtil: FileWriterUtil) -> UIViewController {
        let presenter = CreatePresenter(storage: storage, fileUtil: fileUtil)
        let viewcontroller = CreateViewController(presenter: presenter)
        presenter.set(view: viewcontroller)
        
        return viewcontroller
    }
    
    func getRandomizerScreen(models: [RandItemCellModel]) -> UIViewController {
        let viewcontroller = RandomizerViewController(models: models)
        return viewcontroller
    }
    
    func getShowScreen(storage: UserDefaultStorage, type: ItemType) -> UIViewController {
        let presenter = ShowPresenter(storage: storage, type: type)
        let viewcontroller = ShowViewController(presenter: presenter)
        presenter.set(view: viewcontroller)
        
        return viewcontroller
    }
    
    
    func getFilesScreen(filesUtil: FileWriterUtil) -> UIViewController {
        let presenter = FilesPresenter(filesUtil: filesUtil)
        let viewcontroller = FilesViewController(presenter: presenter)
        presenter.set(view: viewcontroller)
        
        return viewcontroller
    }
    
    func getDisplayActionDataScreen(data: [RandItemCellModel], storage: UserDefaultStorage) -> UIViewController {
        let presenter = DisplayActionDataPresenter(data: data, storage: storage)
        let viewcontroller = DisplayActionDataViewController(presenter: presenter)
        presenter.set(view: viewcontroller)
        
        return viewcontroller
    }
    
    func getDisplayInfoDataScreen(data: [InfoModel], storage: UserDefaultStorage) -> UIViewController {
        let presenter = DisplayInfoDataPresenter(data: data, storage: storage)
        let viewcontroller = DisplayInfoDataViewController(presenter: presenter)
        presenter.set(view: viewcontroller)
        
        return viewcontroller
    }
    
    func getDisplayRawDataScreen(data: String, storage: UserDefaultStorage) -> UIViewController {
        let presenter = DisplayRawDataPresenter(data: data, storage: storage)
        let viewcontroller = DisplayRawDataViewController(presenter: presenter)
        presenter.set(view: viewcontroller)
        
        return viewcontroller
    }
    
    func getSettingScreen(storage: UserDefaultStorage) -> UIViewController {
        let presenter = SettingsPresenter(storage: storage)
        let viewcontroller = SettingsViewController(presenter: presenter)
        presenter.set(view: viewcontroller)
        
        return viewcontroller
    }
    
}
