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
    
    @IBOutlet weak var prepareReport: UIButton!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    @IBAction func didPrepareReportClick(_ sender: Any) {
        self.presenter.prepareReport()
    }
    
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
        
        
        self.prepareReport.setTitle(Translations.Settings.randomReport, for: .normal)
        self.tableView.dataSource = dataSource
        self.tableView.tableFooterView = UIView()
        
        self.loader.style = UIActivityIndicatorView.Style.large
        self.loader.color = .colorMain
        
        self.presenter.viewDidLoad()
    }

    
    func showLoadingState(){
        self.tableView.isHidden = true
        self.emptyView.isHidden = false
        self.prepareReport.isHidden = true
        self.loader.startAnimating()
        self.loader.isHidden = false
    }
    
    func showResultsState(data: [ReportModel]){
        self.registerCells(models: data)
        self.loader.stopAnimating()
        self.prepareReport.isHidden = true
        self.loader.isHidden = true
        self.emptyView.isHidden = true
        self.tableView.isHidden = false
    }
    
    func showInitialState(){
        self.loader.stopAnimating()
        self.tableView.isHidden = true
        self.emptyView.isHidden = false
        self.prepareReport.isHidden = false
        self.loader.isHidden = true
    }
    
    
    private func registerCells(models: [ReportModel]){
        
        models.forEach{
            let nib = UINib(nibName: $0.reuseIdentifier, bundle: nil)
            self.tableView?.register(nib, forCellReuseIdentifier: $0.reuseIdentifier)
        }
        
        self.dataSource.setData(data: models)
        self.tableView.reloadData()
    }

}
