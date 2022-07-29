//
//  NotesInstructionViewController.swift
//  RS
//
//  Created by ICoon on 29.06.2022.
//

import UIKit

public final class NotesInstructionViewController: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private let dataSource = NotesInstructionDataSource()
    
    private let presenter: NotesInstructionPresenter
    
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: NotesInstructionPresenter) {
        self.presenter = presenter
        
        super.init(nibName: "NotesInstructionViewController", bundle: Bundle.main)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = dataSource
        self.tableView.dataSource = dataSource
        self.tableView.tableFooterView = UIView()
        self.dataSource.delegate = self
        self.registerCells()
        
        self.presenter.viewDidLoad()
    }
    
    func onDataLoaded(data: [NotesInstuctionInfoCellModel]){
        self.dataSource.setData(data: data)
        self.tableView.reloadData()
    }
    
    private func registerCells(){
        let headerId = self.dataSource.getNoteInstructionHeaderCellId()
        let headerNib = UINib(nibName: headerId, bundle: nil)
        
        let noteId = self.dataSource.getNoteInstructionCellId()
        let noteNib = UINib(nibName: noteId, bundle: nil)
        
        self.tableView?.register(headerNib, forCellReuseIdentifier: headerId)
        self.tableView?.register(noteNib, forCellReuseIdentifier: noteId)
    }
    
}

extension NotesInstructionViewController: NotesInstructionDelegate{
    
    func howToCreateNote(model: NotesInstuctionInfoCellModel) {
        let navigator = getAppComponent().getNavigator()
        let controller = navigator.getDisplayRawDataScreen(data: model.data)
        navigator.navigate(start: self, destination: controller)
    }
    
    
}
