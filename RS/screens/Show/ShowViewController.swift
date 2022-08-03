//
//  ShowViewController.swift
//  HobbyRandomizer
//
//  Created by ICoon on 09.06.2022.
//

import UIKit

public final class ShowViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
        
    private let dataSource = ShowDataSource()
    
    private let presenter: ShowPresenter
    
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: ShowPresenter) {
        self.presenter = presenter
        
        super.init(nibName: "ShowViewController", bundle: Bundle.main)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = dataSource
        self.tableView.dataSource = dataSource
        self.tableView.tableFooterView = UIView()
        self.dataSource.delegate = self
        self.registerCells()

        self.presenter.viewDidLoad()
    }
    
    
    func onDataLoaded(data: [RandItemCellModel], type: ItemType){
        self.dataSource.setData(data: data)
        self.dataSource.setType(type: type)
        self.tableView.reloadData()
    }
    
    private func navigateToRandom(){
        let navigator =  getAppComponent().getNavigator()
        let alertUtil = getAppComponent().getAlertUtil()
        let destination = navigator.getRandomizerScreen(models: self.dataSource.getData(), alertUtil: alertUtil)
        navigator.navigate(start: self, destination: destination)
    }

    private func registerCells(){
        let randId = self.dataSource.getRandCellIdentifier()
        let randNib = UINib(nibName: randId, bundle: nil)
        let topId = self.dataSource.getTopCellIdentifier()
        let topNib = UINib(nibName: topId, bundle: nil)
        
        self.tableView?.register(randNib, forCellReuseIdentifier: randId)
        self.tableView?.register(topNib, forCellReuseIdentifier: topId)
    }

}

extension ShowViewController: ShowDataSourceDelegate{
    func startRandomDidClick() {
        self.navigateToRandom()
    }
}
