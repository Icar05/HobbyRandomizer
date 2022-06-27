//
//  DisplayInfoDataViewController.swift
//  RS
//
//  Created by ICoon on 26.06.2022.
//

import UIKit

public final class DisplayInfoDataViewController: UIViewController {
    
    
    
    @IBOutlet weak var emptyViewLabel: UILabel!
    
    @IBOutlet weak var emptyView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    private let dataSource = DisplayInfoDataSource()
    
    private let presenter: DisplayInfoDataPresenter
    
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: DisplayInfoDataPresenter) {
        self.presenter = presenter
        
        super.init(nibName: "DisplayInfoDataViewController", bundle: Bundle.main)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = dataSource
        self.tableView.dataSource = dataSource
        self.tableView.tableFooterView = UIView()
        self.registerCells()
        self.emptyViewLabel.text = Translations.All.noData
        self.dataSource.delegate = self
        self.tableView.setValue(0, forKey: "sectionHeaderTopPadding")
                
        self.presenter.viewDidLoad()
    }
    
    func displayData(data: [InfoModel]){
        self.dataSource.setData(data: data.map{$0.toDisplayInfoModel()})
        self.tableView.isHidden = false
        self.tableView.reloadData()
        self.emptyView.isHidden = !data.isEmpty
    }
    
    private func registerCells(){
        let cathegoryId = self.dataSource.getCathegoryCellIdentifier()
        let cathegoryNib = UINib(nibName: cathegoryId, bundle: nil)
        
        let infoDetailId = self.dataSource.getInfoDetailCellIdentifier()
        let infoDetailNib = UINib(nibName: infoDetailId, bundle: nil)
        
        self.tableView?.register(cathegoryNib, forCellReuseIdentifier: cathegoryId)
        self.tableView?.register(infoDetailNib, forCellReuseIdentifier: infoDetailId)
    }
    
}

extension DisplayInfoDataViewController: DisplayInfoDelegate{
    
    func onCollapsed(indexPath: [IndexPath]) {
        self.tableView.deleteRows(at: indexPath, with: .fade)
    }
    
    func onExpanded(indexPath: [IndexPath]) {
        self.tableView.insertRows(at: indexPath, with: .fade)
    }
}
