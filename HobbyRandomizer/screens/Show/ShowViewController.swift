//
//  ShowViewController.swift
//  HobbyRandomizer
//
//  Created by ICoon on 09.06.2022.
//

import UIKit

public final class ShowViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    private let dataSource = ShowDataSource()
    
    private let presenter: ShowPresenter
    
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presener: ShowPresenter) {
        self.presenter = presener
        
        super.init(nibName: "ShowViewController", bundle: Bundle.main)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter.viewDidLoad()
    }
    
    func onDataLoaded(data: [RandItemCellModel]){
        self.dataSource.setData(data: data)
        self.tableView.reloadData()
    }


}
