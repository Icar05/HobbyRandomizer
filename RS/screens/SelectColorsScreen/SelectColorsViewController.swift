//
//  SelectColorsViewController.swift
//  RS
//
//  Created by ICoon on 29.06.2022.
//

import UIKit

public final class SelectColorsViewController: UIViewController {
    
    
    
    private var soundUtil: SoundUtil? = nil
    
    @IBOutlet weak var tableView: UITableView!
    
    private let dataSource = SelectColorsDataSourse()
    
    private let presenter: SelectColorsPresenter
    
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: SelectColorsPresenter) {
        self.presenter = presenter
        
        super.init(nibName: "SelectColorsViewController", bundle: Bundle.main)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = dataSource
        self.tableView.dataSource = dataSource
        self.tableView.tableFooterView = UIView()
        self.dataSource.delegate = self
        self.registerCells()
        self.tableView.setValue(0, forKey: "sectionHeaderTopPadding")
        
        self.presenter.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.soundUtil = getAppComponent().getSoundUtil(sound: .Click)
    }
    
    func displayData(data: [SelectColorModel]){
        self.dataSource.setData(data: data)
        self.tableView.reloadData()
    }
    
    private func registerCells(){
        let id = self.dataSource.getIdentifier()
        let nib = UINib(nibName: id, bundle: nil)
        
        self.tableView?.register(nib, forCellReuseIdentifier: id)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            self.presenter.savePreferences()
        }
    }
    
}

extension SelectColorsViewController: SelectColorsDelegate{
    
    
    func onCollapsed(indexPath: [IndexPath]) {
        self.tableView.deleteRows(at: indexPath, with: .fade)
        self.soundUtil?.play()
    }
    
    func onExpanded(indexPath: [IndexPath]) {
        self.tableView.insertRows(at: indexPath, with: .fade)
        self.soundUtil?.play()
    }
    
    
    func didColorChange(type: SelectType, color: Color) {
        presenter.colorDidChange(type: type, color: color)
    }
}
