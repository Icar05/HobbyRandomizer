//
//  DisplayActionDataViewController.swift
//  RS
//
//  Created by ICoon on 26.06.2022.
//

import UIKit

public final class DisplayActionDataViewController:  UIViewController {
    
    
    
    
    @IBOutlet weak var emptyViewLabel: UILabel!
    
    @IBOutlet weak var emptyView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    private let dataSource = DisplayActionDataDataSourse()
    
    private let presenter: DisplayActionDataPresenter
    
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: DisplayActionDataPresenter) {
        self.presenter = presenter
        
        super.init(nibName: "DisplayActionDataViewController", bundle: Bundle.main)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = dataSource
        self.tableView.dataSource = dataSource
        self.tableView.tableFooterView = UIView()
        self.registerCells()
        self.dataSource.delegate = self
        self.emptyViewLabel.text = Translations.All.noData
        
        self.presenter.viewDidLoad()
    }
    
    func onDataExported(value: Bool){
        self.showAlert(value: value)
    }
    
    func displayData(data: [RandItemCellModel]){
        self.dataSource.setData(data: data)
        self.tableView.isHidden = false
        self.tableView.reloadData()
        self.emptyView.isHidden = !data.isEmpty
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

extension DisplayActionDataViewController: DisplayActionSourceDelegate{
    
    func didRandomClick() {
        print("didRandomClick")
    }
    
    
    func didImportClick() {
        self.presenter.importData()
    }
}
