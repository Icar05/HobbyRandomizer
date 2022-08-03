//
//  CreateViewController.swift
//  HobbyRandomizer
//
//  Created by ICoon on 08.06.2022.
//

import UIKit

public final class CreateViewController: UIViewController, CreateDataSourceDelegate {
   
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let presenter: CreatePresenter
    
    fileprivate let dataSource = CreateViewDataSource()
    
    fileprivate let alertUtil: AlertUtil

    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: CreatePresenter, alertUtil: AlertUtil) {
        self.presenter = presenter
        self.alertUtil = alertUtil
        super.init(nibName: "CreateViewController", bundle: Bundle.main)
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = dataSource
        self.tableView.dataSource = dataSource
        self.tableView.tableFooterView = UIView()
        self.registerCells()
        
        self.dataSource.delegate = self
        self.presenter.viewDidLoad()
    }
    
    func onModelLoaded(models: [RandItemCellModel]){
        self.dataSource.setData(data: models)
        self.tableView.reloadData()
    }
    
    func onModelCreated(freshModels: [RandItemCellModel]) {
        self.presenter.saveModels(models: freshModels)
        self.tableView.reloadData()
    }
    
    func onModelDeleted(freshModels: [RandItemCellModel]) {
        self.presenter.saveModels(models: freshModels)
        self.tableView.reloadData()
    }
    
    func onClearDatatDidTap(indexPath: [IndexPath]) {
        self.tableView.deleteRows(at: indexPath, with: .fade)
        self.tableView.reloadData()
        self.presenter.clearData()
    }
    
    func onClearFinished(value: Bool){
        self.showAlert(value: value)
    }
    
    private func showAlert(value: Bool){
        let title = value ? Translations.Alert.success : Translations.Alert.failure
        let subtitle = value ? Translations.Alert.successDeleteMessage : Translations.Alert.failureMessage
        self.showAlert(alert: alertUtil.getAlert(title: title, subtitle: subtitle))
    }
    
    private func registerCells(){
        let randId = self.dataSource.getRandCellIdentifier()
        let createId = self.dataSource.getCreateItemCellIdentifier()
        let exportId = self.dataSource.getExportCellIndifier()
        
        let randNib = UINib(nibName: randId, bundle: nil)
        let createNib = UINib(nibName: createId, bundle: nil)
        let exportNib = UINib(nibName: exportId, bundle: nil)
        
        self.tableView?.register(randNib, forCellReuseIdentifier: randId)
        self.tableView?.register(createNib, forCellReuseIdentifier: createId)
        self.tableView?.register(exportNib, forCellReuseIdentifier: exportId)
    }
}
