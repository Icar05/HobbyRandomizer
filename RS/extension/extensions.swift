//
//  extensions.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 14.10.2021.
//

import UIKit


extension UIColor {
    static let colorMain = UIColor(named: "MainColor")
    static let lightGreen = UIColor(hexColor: "34C759")
    static let coolGreen = UIColor(hexColor: "349C52")
    static let coolRed = UIColor(hexColor: "E30002")
    static let coolOrange = UIColor(hexColor: "FAA602")
    static let colorCoolViolet = UIColor(hexColor: "633EBF")
    static let colorBorderGray = UIColor(hexColor: "E5E5EA")
    static let colorCappuccino = UIColor(hexColor: "C5AB9F")
    static let colorCocoa = UIColor(hexColor: "775554")
    static let topGB = UIColor(hexColor: "#004d38")
    static let midGB = UIColor(hexColor:  "#117c5e")
    static let bottomGB = UIColor(hexColor: "#69bb9b")
    static let lightBlue = UIColor(hexColor: "#3cdfff")
}

struct Color : Codable {
    var red : CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0
    
    var uiColor : UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    init(uiColor : UIColor) {
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
}

extension Color: Equatable{
    func getName() -> String{
        let names: [UIColor : String ] = [
            UIColor.red : Translations.Color.red,
            UIColor.coolRed! : Translations.Color.customRed,
            UIColor.coolOrange!: Translations.Color.customOrange,
            UIColor.orange: Translations.Color.orange,
            UIColor.yellow: Translations.Color.yellow,
            UIColor.lightGreen!: Translations.Color.green,
            UIColor.coolGreen!: Translations.Color.customGreen,
            UIColor.lightBlue!: Translations.Color.blue,
            UIColor.blue: Translations.Color.systemIndigo,
            UIColor.purple: Translations.Color.purple,
            UIColor.colorCoolViolet!: Translations.Color.customViolet,
            UIColor.colorCappuccino!: Translations.Color.colorCappuccino,
            UIColor.colorCocoa!: Translations.Color.colorCocoa,
            UIColor.colorBorderGray!: Translations.Color.gray
        ]
        
        let name = names[uiColor]
        
        if(name == nil){
            return "\(uiColor.hexStringFromColor())"
        }else{
            return name!
        }
    }
}

extension UITableViewCell{
    func modify(){
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
        selectionStyle = .none
    }
}

extension UIView{
    
    func border(color: UIColor){
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
    }
    
    /**
     just cool view background, i will use it later
     */
    func gradientOrage(){
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func gradientRainbow() {
        guard let top = UIColor.coolRed?.cgColor,
              let mid = UIColor.coolOrange?.cgColor,
              let bot = UIColor.coolGreen?.cgColor
        else {
            return
        }
        
        let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [top, mid, bot]
            gradientLayer.locations = [0.1, 0.5, 1.0]
            gradientLayer.frame = self.bounds
                
        self.layer.insertSublayer(gradientLayer, at:0)
    }
}

extension Notification.Name {
    static let timerNotification = Notification.Name("timerNotification")
}

extension UIViewController{
    
    func showAlert(alert: UIAlertController){
        self.present(alert, animated: true)
    }
    
    func blurEffect(){
        let blurEffect = UIBlurEffect(style: .light)
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
            blurVisualEffectView.frame = view.bounds
        self.view.addSubview(blurVisualEffectView)
    }
    
    func getAppComponent() -> AppComponent{
        return getAppDelegate().getAppComponent()
    }
    
    func getAppDelegate() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func reLoadNavigationSound(){
        (self.navigationController as? InitialViewController)?.reLoadSound()
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


public extension UIImage {
    convenience init?(source: String, bundle: Bundle) {
        if #available(iOS 13.0, *) {
            self.init(named: source, in: bundle, with: .none)
        } else {
            self.init(named: source)
        }
    }
}

extension Int{
    func toSeconds() -> Int{
        return self * 60
    }
    
    func toMinutes() -> Int{
        return self / 60
    }
}

extension Double{
    func toSeconds() -> Double{
        return self * 60
    }
}

extension UIImageView{
    func setImageColor(color: UIColor){
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
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
    
    func hexStringFromColor() -> String {
        let components = self.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        print(hexString)
        return hexString
     }
}

extension String{
    
    
    
    //right is the first encountered string after left
    func between(_ left: String, _ right: String) -> String? {
        guard let leftRange = range(of: left), let rightRange = range(of: right, options: .backwards)
                ,leftRange.upperBound <= rightRange.lowerBound else { return nil }
        
        let sub = self[leftRange.upperBound...]
        let closestToLeftRange = sub.range(of: right)!
        return String(sub[..<closestToLeftRange.lowerBound])
    }
    
    var withoutSpecialCharacters: String {
        return self.replacingOccurrences(of: "\\s", with: "", options: .regularExpression)
    }
    
    func truncate(length: Int, trailing: String = "") -> String {
        if self.count > length {
            return String(self.prefix(length)) + trailing
        } else {
            return self
        }
    }
    
    func titleCase() -> String {
        return self
            .replacingOccurrences(of: "([A-Z])",
                                  with: " $1",
                                  options: .regularExpression,
                                  range: range(of: self))
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .capitalized // If input is in llamaCase
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "\(self)_comment")
    }
    
    func localized(_ args: CVarArg...) -> String {
        return String(format: localized, args)
    }
}

extension Bundle {
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
        object(forInfoDictionaryKey: "CFBundleName") as? String
    }
}


extension Array {
    
    var tail: Array {
        return Array(self.dropFirst())
    }
    
}
