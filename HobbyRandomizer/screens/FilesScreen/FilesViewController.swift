//
//  FilesViewController.swift
//  HobbyRandomizer
//
//  Created by ICoon on 23.06.2022.
//

import UIKit

public final class FilesViewController: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private let dataSource = FilesDataSource()
    
    private let presenter: FilesPresenter
    
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: FilesPresenter) {
        self.presenter = presenter
        
        super.init(nibName: "FilesViewController", bundle: Bundle.main)
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
    
    
    func onDataLoaded(data: [String]){
        self.dataSource.setData(data: data.map{DisplayFileCellModel(fileName: $0)})
        self.tableView.reloadData()
    }

    private func registerCells(){
        let randId = self.dataSource.getIdentifier()
        let randNib = UINib(nibName: randId, bundle: nil)
        
        self.tableView?.register(randNib, forCellReuseIdentifier: randId)
    }


}

extension FilesViewController: FileDataSourceDelegate{
    
    func onItemSelected(model: DisplayFileCellModel) {
        presenter.parseFileData(fileName: model.fileName)
    }
    
    
}
