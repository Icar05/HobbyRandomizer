//
//  SettingsViewController.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 15.10.2021.
//

import UIKit

struct SettingsModel{
    let image: UIImage
    let title: String
    let type: UIViewController.Type
}

class SettingsViewController: UIViewController {
    
    
    let dataSource = [
        
        SettingsModel(
            image:UIImage(systemName: "suit.spade.fill")!,
            title: "Casino",
            type: CasinoViewController.self)
    ]
    
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
    }

}

extension SettingsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Settings", for: indexPath) as! SettingCell
            cell.setData(data: dataSource[indexPath.row])
            cell.modify()
        
        return cell
    }
    
}

extension SettingsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showViewController(type: dataSource[indexPath.row].type)
    }
}

extension SettingsViewController{
    
    func showViewController<T>(type: T.Type) where T: UIViewController{
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: String(describing: type)) as! T
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}
