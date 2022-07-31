//
//  AppDelegate.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 12.10.2021.
//

import UIKit

let retroStyle = true

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    
    
    private let appComponent = AppComponent()
    
    var window: UIWindow?

    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.appComponent.getNavigator().setupInitialViewController(window: window!)
        self.appComponent.getTestUtil().startTest()
        self.checkNotificationPermission()
        
        return true
    }
    
    
    func getAppComponent() -> AppComponent{
        return appComponent
    }
   
    /**
        request permissions for notifications
     */
    private func checkNotificationPermission(){
        self.appComponent.getNotificationUtil().checkNotificationPermission {
            DispatchQueue.main.async {
                self.handleDisabledPermission()
            }
        }
    }
    
    private func handleDisabledPermission(){
        
        guard let window = window , let rootViewController = window.rootViewController else {
            return
        }
        
        let alert = self.appComponent.getAlertUtil().getAlert()
        rootViewController.blurEffect()
        rootViewController.present(alert, animated: true)
    }
}

