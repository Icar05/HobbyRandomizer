//
//  DisplayRawDataViewController.swift
//  RS
//
//  Created by ICoon on 26.06.2022.
//

import UIKit

public final class DisplayRawDataViewController: UIViewController {
    
    
    
    @IBOutlet weak var emptyViewLabel: UILabel!
    
    @IBOutlet weak var emptyView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    private let dataSource = DisplayRawDataDataSourse()
    
    private let presenter: DisplayRawDataPresenter
    
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: DisplayRawDataPresenter) {
        self.presenter = presenter
        
        super.init(nibName: "DisplayRawDataViewController", bundle: Bundle.main)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = dataSource
        self.tableView.dataSource = dataSource
        self.tableView.tableFooterView = UIView()
        self.registerCells()
        self.emptyViewLabel.text = Translations.All.noData
        
        self.presenter.viewDidLoad()
    }
    
    func displayData(data: String){
        self.dataSource.setData(data: data)
        self.tableView.isHidden = false
        self.tableView.reloadData()
        self.emptyView.isHidden = !data.isEmpty
    }
    
    private func registerCells(){
        let randId = self.dataSource.getIdentifier()
        let randNib = UINib(nibName: randId, bundle: nil)
        
        let importId = self.dataSource.getImportCellIdentifier()
        let importNib = UINib(nibName: importId, bundle: nil)
        
        self.tableView?.register(randNib, forCellReuseIdentifier: randId)
        self.tableView?.register(importNib, forCellReuseIdentifier: importId)
    }
    
}
