//
//  CreateViewController.swift
//  HobbyRandomizer
//
//  Created by ICoon on 08.06.2022.
//

import UIKit

public final class CreateViewController: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let presenter: CreatePresenter
    
    fileprivate let dataSource = CreateViewDataSource()
    

    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: CreatePresenter) {
        self.presenter = presenter
        super.init(nibName: "CreateViewController", bundle: Bundle.main)
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = dataSource
        self.tableView.dataSource = dataSource
        self.tableView.tableFooterView = UIView()
        self.registerCells()
        
        self.presenter.viewDidLoad()
    }
    
    func onModelLoaded(models: [RandItemCellModel]){
        self.dataSource.setData(data: models)
        self.tableView.reloadData()
    }
    
    func onModelCreated(model: RandItemCellModel){
//        self.datasource.append(model)
//        self.presenter.saveModels(models: self.datasource)
//        self.tableView.reloadData()
    }
    
    private func registerCells(){
        let randId = self.dataSource.getRandCellIdentifier()
        let createId = self.dataSource.getCreateItemCellIdentifier()
        
        let randNib = UINib(nibName: randId, bundle: nil)
        let createNib = UINib(nibName: createId, bundle: nil)
        
        self.tableView?.register(randNib, forCellReuseIdentifier: randId)
        self.tableView?.register(createNib, forCellReuseIdentifier: createId)
    }
}
