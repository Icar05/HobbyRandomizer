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
    
    func getInitialController() -> InitialViewController {
        let navVc = InitialViewController()
        let menuVc = getMenuScreen()
        navVc.viewControllers = [menuVc]
        return navVc
    }
    
    func navigateAlert(start: UIViewController, destination: UIViewController){
        start.navigationController?.present(destination, animated: true)
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
        let presenter = CasinoPresenter()
        let viewcontroller = CasinoViewController(presenter: presenter)
        presenter.set(view: viewcontroller)
        
        return viewcontroller
    }
    
    func getDebugScreen() -> UIViewController {
        let presenter = DebugPresenter()
        let viewcontroller = DebugViewController(presenter: presenter)
        presenter.set(view: viewcontroller)
        
        return viewcontroller
    }
    
    func getTestScreen() -> UIViewController {
        return TestViewController()
    }
    
    func getTimerScreen(storage: UserDefaultStorage, timerUtil: TimerUtil) -> UIViewController {
        let presenter = TimerPresenter(storage: storage)
        let viewController = TimerViewController(presenter: presenter, timerUtil: timerUtil)
        presenter.set(view: viewController)
        
        return viewController
    }
    
    
    func getCreateScreen(storage: UserDefaultStorage, fileUtil: FileWriterUtil, alertUtil: AlertUtil) -> UIViewController {
        let presenter = CreatePresenter(storage: storage, fileUtil: fileUtil)
        let viewcontroller = CreateViewController(presenter: presenter, alertUtil: alertUtil)
        presenter.set(view: viewcontroller)
        
        return viewcontroller
    }
    
    func getRandomizerScreen(models: [RandItemCellModel], alertUtil: AlertUtil) -> UIViewController {
        let presenter = RandomizerViewPresenter()
        let viewcontroller = RandomizerViewController(models: models, presenter: presenter, alertUtil: alertUtil)
        presenter.set(view: viewcontroller)
        
        return viewcontroller
    }
    
    func getShowScreen(storage: UserDefaultStorage, type: ItemType) -> UIViewController {
        let presenter = ShowPresenter(storage: storage, type: type)
        let viewcontroller = ShowViewController(presenter: presenter)
        presenter.set(view: viewcontroller)
        
        return viewcontroller
    }
    
    
    func getFilesScreen(filesUtil: FileWriterUtil, alertUtil: AlertUtil) -> UIViewController {
        let presenter = FilesPresenter(filesUtil: filesUtil)
        let viewcontroller = FilesViewController(presenter: presenter, alertUtil: alertUtil)
        presenter.set(view: viewcontroller)
        
        return viewcontroller
    }
    
    func getFilesDetailScreen(folderName: String, filesUtil: FileWriterUtil, alertUtil: AlertUtil) -> UIViewController {
        let presenter = FilesDetailPresenter(filesUtil: filesUtil, folderName: folderName)
        let viewcontroller = FilesDetailViewController(presenter: presenter, alertUtil: alertUtil)
        presenter.set(view: viewcontroller)
        
        return viewcontroller
    }
    
    func getDisplayActionDataScreen(data: [RandItemCellModel], storage: UserDefaultStorage, alertUtil: AlertUtil) -> UIViewController {
        let presenter = DisplayActionDataPresenter(data: data, storage: storage)
        let viewcontroller = DisplayActionDataViewController(presenter: presenter, alertUtil: alertUtil)
        presenter.set(view: viewcontroller)
        
        return viewcontroller
    }
    
    func getDisplayInfoDataScreen(data: [InfoModel]) -> UIViewController {
        let presenter = DisplayInfoDataPresenter(data: data)
        let viewcontroller = DisplayInfoDataViewController(presenter: presenter)
        presenter.set(view: viewcontroller)
        
        return viewcontroller
    }
    
    func getDisplayRawDataScreen(data: String) -> UIViewController {
        let presenter = DisplayRawDataPresenter(data: data)
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
    
    func getNotesInstructionScreen() -> UIViewController {
        let presenter = NotesInstructionPresenter()
        let viewcontroller = NotesInstructionViewController(presenter: presenter)
        presenter.set(view: viewcontroller)
        
        return viewcontroller
    }
    
    func getSelectColorScreen(storage: UserDefaultStorage) -> UIViewController {
        let presenter = SelectColorsPresenter(storage: storage)
        let viewcontroller = SelectColorsViewController(presenter: presenter)
        presenter.set(view: viewcontroller)
        
        return viewcontroller
    }
    
    func getYesNoScreen(storage: UserDefaultStorage) -> UIViewController {
        let presenter = YesNoPresenter(storage: storage)
        let viewcontroller = YesNoViewController(presenter: presenter)
        presenter.set(view: viewcontroller)
        
        return viewcontroller
    }
    
    func getSelectColorAlert(model: UISelectionDialogModel) -> UIViewController {
        return UISelectionDialog(model: model)
    }
}
