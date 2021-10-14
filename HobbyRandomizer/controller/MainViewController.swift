//
//  MainViewController.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 13.10.2021.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
        
    @IBOutlet weak var tableView: UITableView!
    
    
    fileprivate let viewModel = MainViewModel.shared
    
    
    var datasource: [HobbyModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let models = self.viewModel.getModels()
        if(models != nil){
            self.datasource = models!
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()

    }
    
    func onModelCreated(model: HobbyModel){
        self.datasource.append(model)
        self.viewModel.saveModels(models: self.datasource)
        self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "TC", for: indexPath) as! CreateHobbyCell
                cell.modify()
                cell.setupDelegate{ (model) in self.onModelCreated(model: model)}
                cell.isUserInteractionEnabled = false
                
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HC", for: indexPath) as! HobbyCell
        cell.setData(data: self.datasource[indexPath.row - 1])
        cell.modify()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count + 1
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return indexPath.row == 0 ? UITableViewCell.EditingStyle.none : UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete && indexPath.row > 0 {
            self.datasource.remove(at: indexPath.row - 1)
            self.viewModel.saveModels(models: self.datasource)
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 170: 70
    }
    
}
