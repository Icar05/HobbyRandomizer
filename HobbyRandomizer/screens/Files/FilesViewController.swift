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
    
    
    func onDataLoaded(data: [FileInfo]){
        self.dataSource.setData(data: data.map{ $0.toDisplayFileCellModel()})
        self.tableView.reloadData()
    }
    
    
    func displayModels(data: [RandItemCellModel]){
        let storage = getStorage()
        let controller = getNavigator().getDisplayDataScreen(data: data, storage: storage)
        getNavigator().navigate(start: self, destination: controller)
    }
    
    func displayText(data: String){
        let storage = getStorage()
        let controller = getNavigator().getDisplayDataScreen(data: data, storage: storage)
        getNavigator().navigate(start: self, destination: controller)
    }
    
    func didFileRemoved(value: Bool){
        self.showAlert(value: value)
    }
    
    private func getStorage() -> UserDefaultStorage {
        return (UIApplication.shared.delegate as! AppDelegate).getStorage()
    }
    
    private func getNavigator() -> Navigator{
        return (UIApplication.shared.delegate as! AppDelegate).getNavigator()
    }

    private func registerCells(){
        let randId = self.dataSource.getIdentifier()
        let randNib = UINib(nibName: randId, bundle: nil)
        
        self.tableView?.register(randNib, forCellReuseIdentifier: randId)
    }

    private func showAlert(value: Bool){
        let title = value ? "Success" : "Failure"
        let subtitle = value ? "File has been successfully removed!" : "Something went wrong!"
        self.showAlert(title: title, subtitle: subtitle)
    }

}

extension FilesViewController: FileDataSourceDelegate{
    
    func onItemRemoved(fileName: String) {
        self.tableView.reloadData()
        presenter.removeItemByName(fileName: fileName)
    }
    
    
    func onItemSelected(model: DisplayFileCellModel) {
        presenter.parseFileData(fileName: model.fileName)
    }
    
    
}
