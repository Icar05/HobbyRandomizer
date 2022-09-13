//
//  OpenFileViewController.swift
//  RS
//
//  Created by ICoon on 11.09.2022.
//

import UIKit


public final class OpenFileViewController: UIViewController {

    
    
    private let presenter: OpenFilePresenter
    
    @IBAction func actionClick(_ sender: Any) {
        self.presenter.showAllFiles()
    }
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: OpenFilePresenter) {
        self.presenter = presenter
        
        super.init(nibName: "OpenFileViewController", bundle: Bundle.main)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableView.delegate = dataSource
//        self.tableView.dataSource = dataSource
//        self.tableView.tableFooterView = UIView()
//        self.dataSource.delegate = self
//        self.registerCells()
//        self.emptyViewLabel.text = Translations.All.noData
//
//        self.presenter.viewDidLoad()
    }

}
