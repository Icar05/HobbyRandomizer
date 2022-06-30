//
//  SettingsViewController.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import UIKit

public final class SettingsViewController: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private let dataSource = SettingsDataSourse()
    
    private let presenter: SettingsPresenter
    
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: SettingsPresenter) {
        self.presenter = presenter
        
        super.init(nibName: "SettingsViewController", bundle: Bundle.main)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = dataSource
        self.tableView.dataSource = dataSource
        self.tableView.tableFooterView = UIView()

       
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.presenter.fetchFreshData()
    }
    
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            self.presenter.savePreferences()
        }
    }
    
    func navigateToColorSelection(){
        presenter.savePreferences()
        
        let storage = (UIApplication.shared.delegate as! AppDelegate).getStorage()
        let navigator = (UIApplication.shared.delegate as! AppDelegate).getNavigator()
        let destination = navigator.getSelectColorScreen(storage: storage)
        navigator.navigate(start: self, destination: destination)
    }
    
    func registerCells(models: [SettingsModel]){
        
        models.forEach{
            let nib = UINib(nibName: $0.reuseIdentifier, bundle: nil)
            self.tableView?.register(nib, forCellReuseIdentifier: $0.reuseIdentifier)
        }
        
        self.dataSource.setData(data: models)
        self.tableView.reloadData()
    }
    
}
