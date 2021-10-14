//
//  extensions.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 14.10.2021.
//

import UIKit


extension UIColor {
    static let coolGreen = UIColor(named: "CoolGreen")
    static let colorMain = UIColor(named: "MainColor")
    static let colorBorderGray = UIColor(named: "BorderGray")
}

extension UITableViewCell{
    func modify(){
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
        selectionStyle = .none
    }
}


extension UIViewController{
    func showAlert(model: HobbyModel){
        let alert = UIAlertController(title: model.title, message: model.description, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension UIImageView{
    func border(){
        layer.masksToBounds = true
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.colorBorderGray?.cgColor
        layer.cornerRadius = 8
    }
}
