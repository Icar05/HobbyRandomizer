//
//  extensions.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 14.10.2021.
//

import UIKit


extension UIColor {
    static let coolGreen = UIColor(hexColor: "349C52")
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
    func showAlert(model: RandItemCellModel){
        let alert = UIAlertController(title: model.title, message: model.subTitle, preferredStyle: .alert)
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

extension UIColor {
    public convenience init?(hexColor: String){
        var cString:String = hexColor.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

           if (cString.hasPrefix("#")) {
               cString.remove(at: cString.startIndex)
           }

           if ((cString.count) != 6) {
               return nil
           }

           var rgbValue:UInt64 = 0
           Scanner(string: cString).scanHexInt64(&rgbValue)

            self.init(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
            return
    }
}
