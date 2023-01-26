//
//  RandomReportViewController.swift
//  RS
//
//  Created by Галяткин Александр on 26.01.2023.
//

import UIKit

public final class RandomReportViewController: UIViewController {
    
    
    
    private let dataSource = RandomReportDataSource()
    
    private let presenter: RandomReportPresenter
        
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    
    @IBOutlet weak var emptyViewLabel: UILabel!
    
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: RandomReportPresenter) {
        self.presenter = presenter
        
        super.init(nibName: "RandomReportViewController", bundle: Bundle.main)
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableView.delegate = dataSource
//        self.tableView.dataSource = dataSource
//        self.tableView.tableFooterView = UIView()
//        self.registerCells()
//        self.emptyViewLabel.text = Translations.All.noData
    }


}
