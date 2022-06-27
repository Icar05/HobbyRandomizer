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
        self.registerCells()
        
        self.presenter.viewDidLoad()
    }
    
    
    private func registerCells(){
        let settingsId = self.dataSource.getSettingsHeaderIdentifier()
        let settingsNib = UINib(nibName: settingsId, bundle: nil)
        
        let importId = self.dataSource.getImportCellIdentifier()
        let importNib = UINib(nibName: importId, bundle: nil)
        
        self.tableView?.register(settingsNib, forCellReuseIdentifier: settingsId)
        self.tableView?.register(importNib, forCellReuseIdentifier: importId)
    }
    
}

