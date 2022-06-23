//
//  DisplayDataViewController.swift
//  HobbyRandomizer
//
//  Created by ICoon on 23.06.2022.
//

import UIKit

public final class DisplayDataViewController:  UIViewController {
    
    @IBOutlet weak var exportData: LabelWithCallBack!
    
    @IBOutlet weak var simpleViewLabel: UILabel!
    
    @IBOutlet weak var simpleView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    private let dataSource = ShowDataSource()
    
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

        self.exportData.callback = {
            self.presenter.exportData()
        }
        
        self.presenter.viewDidLoad()
    }
    
    func onDataExported(value: Bool){
        self.showAlert(value: value)
    }
    
    func displayData(data: String){
        self.exportData.isHidden = true
        self.simpleView.isHidden = false
        self.tableView.isHidden = true
        self.simpleViewLabel.text = data
    }
    
    func displayData(data: [RandItemCellModel]){
        self.dataSource.setData(data: data)
        self.exportData.isHidden = false
        self.simpleView.isHidden = true
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    private func showAlert(value: Bool){
        let title = value ? "Success" : "Failure"
        let subtitle = value ? "Data has been successfully imported!" : "Something went wrong!"
        self.showAlert(title: title, subtitle: subtitle)
    }
    
    private func registerCells(){
        let randId = self.dataSource.getRandCellIdentifier()
        let randNib = UINib(nibName: randId, bundle: nil)
        
        self.tableView?.register(randNib, forCellReuseIdentifier: randId)
    }


}
