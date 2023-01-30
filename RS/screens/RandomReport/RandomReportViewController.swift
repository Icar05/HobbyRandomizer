//
//  RandomReportViewController.swift
//  RS
//
//  Created by Галяткин Александр on 26.01.2023.
//

import UIKit

public final class RandomReportViewController: UIViewController {
    
    
    
    private var soundUtil: SoundUtil? = nil
    
    private let dataSource = RandomReportDataSource()
    
    private let presenter: RandomReportPresenter
        
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var prepareReport: UIButton!
    
    @IBOutlet weak var buttonLabel: UILabel!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    @IBAction func didPrepareReportClick(_ sender: Any) {
        self.presenter.prepareReport()
        self.soundUtil?.play()
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
        
        
        self.buttonLabel.text = Translations.Settings.randomReport
        
        self.tableView.dataSource = dataSource
        self.tableView.tableFooterView = UIView()
        
        self.loader.style = UIActivityIndicatorView.Style.large
        self.loader.color = .colorMain
        
        self.presenter.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.soundUtil = getAppComponent().getSoundUtil(sound: .Click)
    }
    
    func showLoadingState(){
        self.tableView.isHidden = true
        self.prepareReport.isHidden = true
        self.buttonLabel.isHidden = true
        self.loader.startAnimating()
        self.loader.isHidden = false
    }
    
    func showResultsState(data: [ReportModel]){
        self.registerCells(models: data)
        self.loader.stopAnimating()
        self.prepareReport.isHidden = true
        self.buttonLabel.isHidden = true
        self.loader.isHidden = true
        self.tableView.isHidden = false
    }
    
    func showInitialState(){
        self.loader.stopAnimating()
        self.tableView.isHidden = true
        self.prepareReport.isHidden = false
        self.buttonLabel.isHidden = false
        self.loader.isHidden = true
    }
    
    func playClick(){
        self.soundUtil?.play()
    }
    
    
    private func registerCells(models: [ReportModel]){
        
        models.forEach{
            let nib = UINib(nibName: $0.reuseIdentifier, bundle: nil)
            self.tableView?.register(nib, forCellReuseIdentifier: $0.reuseIdentifier)
        }
        
        self.dataSource.setData(data: models)
        self.tableView.reloadData()
        self.soundUtil?.play()
    }

}
