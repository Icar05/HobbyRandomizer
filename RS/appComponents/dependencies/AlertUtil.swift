//
//  AlertUtil.swift
//  RS
//
//  Created by ICoon on 29.07.2022.
//

import Foundation
import simd


class AlertUtil{
    
    func getAlert(model: RandItemCellModel) -> UIAlertController{
        let alert = UIAlertController(title: model.title, message: model.subTitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Translations.Permission.ok, style: .default, handler: nil))
        return alert
    }
    
    func getAlert(title: String, subtitle: String) -> UIAlertController{
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Translations.Permission.ok, style: .default, handler: nil))
        return alert
    }
    
    func getPermissionAlert() -> UIAlertController{

        let alertController = UIAlertController(
            title: Translations.Permission.permissionTitle,
            message: Translations.Permission.permissionSubtitle,
            preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: Translations.Permission.settings, style: .default) { (_) -> Void in
               
               guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                   return
               }
               if UIApplication.shared.canOpenURL(settingsUrl) {
                   UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                       exit(0)
                   })
                }
           }
        
        let cancelAction = UIAlertAction(title: Translations.Permission.cancel, style: .default) {(_) -> Void in
                exit(0)
            }
        
           alertController.addAction(cancelAction)
           alertController.addAction(settingsAction)
        
        return alertController
    }
}
