//
//  FilesViewController.swift
//  HobbyRandomizer
//
//  Created by ICoon on 23.06.2022.
//

import UIKit

public final class FilesViewController: UIViewController {
    
    
    
    private let dataSource = FilesDataSource()
    
    private let presenter: FilesPresenter
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    
    @IBOutlet weak var emptyViewLabel: UILabel!
    
    
    
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
        self.emptyViewLabel.text = Translations.All.noData
        
        self.presenter.viewDidLoad()
    }
    
    
    func onDataLoaded(data: [FileInfo]){
        self.emptyView.isHidden = !data.isEmpty
        self.dataSource.setData(data: data.map{ $0.toDisplayFileCellModel()})
        self.tableView.reloadData()
    }
    
    func displayData(data: [InfoModel]){
        let controller = getAppComponent().getNavigator().getDisplayInfoDataScreen(data: data)
        getAppComponent().getNavigator().navigate(start: self, destination: controller)
    }

    func displayData(data: [RandItemCellModel]){
        let storage = getAppComponent().getStorage()
        let controller = getAppComponent().getNavigator().getDisplayActionDataScreen(data: data, storage: storage)
        getAppComponent().getNavigator().navigate(start: self, destination: controller)
    }
    
    func displayData(data: String){
        let controller = getAppComponent().getNavigator().getDisplayRawDataScreen(data: data)
        getAppComponent().getNavigator().navigate(start: self, destination: controller)
    }
    
    func didFileRemoved(value: Bool){
//        self.showAlert(value: value)
    }

    private func registerCells(){
        let fileId = self.dataSource.getIdentifier()
        let fileNib = UINib(nibName: fileId, bundle: nil)
        
        let questionId = self.dataSource.getQuestionIdentifier()
        let questionNib = UINib(nibName: questionId, bundle: nil)
        
        self.tableView?.register(fileNib, forCellReuseIdentifier: fileId)
        self.tableView?.register(questionNib, forCellReuseIdentifier: questionId)
    }

    private func showAlert(value: Bool){
        let title = value ? Translations.Alert.success : Translations.Alert.success
        let subtitle = value ? Translations.Alert.successRemoveData : Translations.Alert.failureMessage
        self.showAlert(title: title, subtitle: subtitle)
    }

}

extension FilesViewController: FileDataSourceDelegate{
    
    
    func onQuestionDidTap() {
        let navigator = getAppComponent().getNavigator()
        let notesController = navigator.getNotesInstructionScreen()
        navigator.navigate(start: self, destination: notesController)
    }
    
    func onItemRemoved(fileName: String) {
        self.tableView.reloadData()
        self.emptyView.isHidden = self.dataSource.isNotEmpty()
        presenter.removeItemByName(fileName: fileName)
    }
    
    
    func onItemSelected(model: DisplayFileCellModel) {
        presenter.parseFileData(fileName: model.fileName)
    }
    
    
}
