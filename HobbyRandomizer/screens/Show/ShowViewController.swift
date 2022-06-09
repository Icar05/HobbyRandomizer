//
//  ShowViewController.swift
//  HobbyRandomizer
//
//  Created by ICoon on 09.06.2022.
//

import UIKit

public final class ShowViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var label: LabelWithCallBack!
    
    @IBOutlet weak var imageView: UIImageView!
    
    private let dataSource = ShowDataSource()
    
    private let presenter: ShowPresenter
    
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: ShowPresenter) {
        self.presenter = presenter
        
        super.init(nibName: "ShowViewController", bundle: Bundle.main)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = dataSource
        self.tableView.dataSource = dataSource
        self.tableView.tableFooterView = UIView()
        self.registerCells()

        self.presenter.viewDidLoad()
        
        self.label.callback = {
            self.navigateToRandom()
        }
    }
    
    
    func onDataLoaded(data: [RandItemCellModel], type: ItemType){
        self.dataSource.setData(data: data)
        self.tableView.reloadData()
        self.label.backgroundColor = type.getColorForType()
        self.imageView.image = type.getImage()
    }
    
    private func navigateToRandom(){
        let navigator =  (UIApplication.shared.delegate as! AppDelegate).getNavigator()
        let destination = navigator.getRandomizerScreen(models: self.dataSource.getData())
        navigator.navigate(start: self, destination: destination)
    }

    private func registerCells(){
        let randId = self.dataSource.getRandCellIdentifier()
        let randNib = UINib(nibName: randId, bundle: nil)
        
        self.tableView?.register(randNib, forCellReuseIdentifier: randId)
    }

}
