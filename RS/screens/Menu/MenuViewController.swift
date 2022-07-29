//
//  MenuViewController.swift
//  HobbyRandomizer
//
//  Created by ICoon on 07.06.2022.
//

import UIKit

public final class MenuViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    private let dataSource = MenuDataSource()
    
    private let presenter: MenuPresenter
    
    @IBOutlet weak var collectionView: VerticalCollectionView!
    
    @IBOutlet weak var menuTitle: UILabel!
    
    
    
    
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
    
        setupUI()
    }
    
    func didDataUpdate(data: [MenuCellModel]){
        self.dataSource.setData(data: data)
        self.collectionView.reloadData()
    }
    
    private func setupUI(){
        let identifier = self.dataSource.getIdentifier()
        let nib = UINib(nibName: identifier, bundle: nil)
        let appName = Bundle.main.displayName!
        let title = Translations.Menu.mainTitle.replacingOccurrences(of: "AppName", with: appName)
        
        self.collectionView?.register(nib, forCellWithReuseIdentifier: identifier)
        self.collectionView.dataSource = dataSource
        self.collectionView.delegate = dataSource
        self.collectionView.contentSizeDelegate = self
        self.dataSource.setDelegate(delegate: self)

        self.menuTitle.text = title
        self.navigationController?.navigationBar.tintColor = .black
    }
}

extension MenuViewController: MenuDelegate{
    
    func onItemSelected(item: ScreenTypes) {
        
        let appComponent = getAppDelegate().getAppComponent()
        
        guard let destination = getController(item: item, appComponent: appComponent) else {
            print("not implemented: \(item)")
            return
        }

        appComponent.getNavigator().navigate(start: self, destination: destination)
    }
    
    
    func getController(item: ScreenTypes, appComponent: AppComponent) -> UIViewController?{
        
        switch item {
        case .Casino:
            return appComponent.getNavigator().getCasinoScreen()
        case .Test:
            return appComponent.getNavigator().getDebugScreen()
        case .Create:
            return appComponent.getNavigator().getCreateScreen(storage: appComponent.getStorage(), fileUtil: appComponent.getFileUtil())
        case .Todo:
            return appComponent.getNavigator().getShowScreen(storage: appComponent.getStorage(), type: .ToDo)
        case .WeekEnd:
            return appComponent.getNavigator().getShowScreen(storage: appComponent.getStorage(), type: .HappyWeekend)
        case .HardDayNight:
            return appComponent.getNavigator().getShowScreen(storage: appComponent.getStorage(), type: .HardDayNight)
        case .Files:
            return appComponent.getNavigator().getFilesScreen(filesUtil: appComponent.getFileUtil())
        case .Settings:
            return appComponent.getNavigator().getSettingScreen(storage: appComponent.getStorage())
        case .YesNo:
            return appComponent.getNavigator().getYesNoScreen(storage: appComponent.getStorage())
        case .Timer:
            return appComponent.getNavigator().getTimerScreen(storage: appComponent.getStorage(), notificationUtil: appComponent.getNotificationUtil())
        }
    }
}

extension MenuViewController: VerticalColecitonViewDelegate{
    
    func onContentSizeChanged(y: CGFloat) {
        self.bottomConstraint.constant = y - 16
    }
    
}
