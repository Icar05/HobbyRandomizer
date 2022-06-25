//
//  DisplayDataViewController.swift
//  HobbyRandomizer
//
//  Created by ICoon on 23.06.2022.
//

import UIKit

public final class DisplayDataViewController:  UIViewController {
    
    
    
    @IBOutlet weak var simpleViewLabel: UILabel!
    
    @IBOutlet weak var simpleView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    private let dataSource = DisplayDataSource()
    
    private let presenter: DisplayDataPresenter
    
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: DisplayDataPresenter) {
        self.presenter = presenter
        
        super.init(nibName: "DisplayDataViewController", bundle: Bundle.main)
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
    
    func onDataExported(value: Bool){
        self.showAlert(value: value)
    }
    
    func displayData(data: String){
        self.simpleView.isHidden = false
        self.tableView.isHidden = true
        self.simpleViewLabel.text = data
    }
    
    func displayData(data: [RandItemCellModel]){
        self.dataSource.setData(data: data)
        self.simpleView.isHidden = true
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    private func showAlert(value: Bool){
        let title = value ? Translations.Alert.success : Translations.Alert.failure
        let subtitle = value ? Translations.Alert.successImportMessage : Translations.Alert.failureMessage
        self.showAlert(title: title, subtitle: subtitle)
    }
    
    private func registerCells(){
        let randId = self.dataSource.getRandCellIdentifier()
        let randNib = UINib(nibName: randId, bundle: nil)
        
        let importId = self.dataSource.getImportCellIdentifier()
        let importNib = UINib(nibName: importId, bundle: nil)
        
        self.tableView?.register(randNib, forCellReuseIdentifier: randId)
        self.tableView?.register(importNib, forCellReuseIdentifier: importId)
    }

}

extension DisplayDataViewController: DisplayDataSourceDelegate{
    
    func didImportClick() {
        self.presenter.importData()
    }
}
