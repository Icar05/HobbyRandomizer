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
        
        let navigator =  (UIApplication.shared.delegate as! AppDelegate).getNavigator()
        let storage = (UIApplication.shared.delegate as! AppDelegate).getStorage()
        let fileUtil = (UIApplication.shared.delegate as! AppDelegate).getFileUtil()
        
        guard let destination = getController(item: item, navigator: navigator, storage: storage, fileUtil: fileUtil) else {
            print("not implemented: \(item)")
            return
        }

        navigator.navigate(start: self, destination: destination)
    }
    
    
    func getController(item: ScreenTypes, navigator: Navigator, storage: UserDefaultStorage, fileUtil: FileWriterUtil) -> UIViewController?{
        
        switch item {
        case .Casino:
            return navigator.getCasinoScreen(storage: storage)
        case .Test:
            return navigator.getDebugScreen()
        case .Create:
            return navigator.getCreateScreen(storage: storage, fileUtil: fileUtil)
        case .Todo:
            return navigator.getShowScreen(storage: storage, type: .necessary)
        case .Hobby:
            return navigator.getShowScreen(storage: storage, type: .freetime)
        case .WorkInProgress:
            return navigator.getShowScreen(storage: storage, type: .workInProgress)
        case .Files:
            return navigator.getFilesScreen(filesUtil: fileUtil)
        case .Settings:
            return navigator.getSettingScreen(storage: storage)
        }
    }
}

extension MenuViewController: VerticalColecitonViewDelegate{
    func onContentSizeChanged(y: CGFloat) {
        self.bottomConstraint.constant = y - 16
    }
    
    
}
