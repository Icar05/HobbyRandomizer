//
//  AppDelegate.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 12.10.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?
    
    private let navigator: Navigator = NavigatorImpl()
    
    private let storage: UserDefaultStorage = UserDefaultStorage()
    
    private let fileUtil: FileWriterUtil = FileWriterUtil()
    
    private var testUtil: TestUtil? = nil
    
    private let alertUtil = AlertUtil()
    
    private let notificationUtil = NotificationUtil()
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.navigator.setupInitialViewController(window: window!)
        self.testUtil = TestUtil(fileUtil: fileUtil)
        self.testUtil?.startTest()
        self.checkNotificationPermission()
       
        
        return true
    }
    
    func getSoundUtil(sound: SoundCaf) -> SoundUtil{
        let model = getStorage().getAppPreferences()
        return SoundUtil(enable: model.isEnabledSound, volume: model.volume, sound: sound)
    }
    
    func getNavigator() -> Navigator{
        return self.navigator
    }
    
    func getStorage() -> UserDefaultStorage{
        return self.storage
    }
    
    func getFileUtil() -> FileWriterUtil{
        return fileUtil
    }
    
    func getNotificationUtil() -> NotificationUtil{
        return notificationUtil
    }
   
    /**
        permissions
     */
    private func checkNotificationPermission(){
        self.notificationUtil.checkNotificationPermission {
            DispatchQueue.main.async {
                self.handleDisabledPermission()
            }
        }
    }
    
    private func handleDisabledPermission(){
        
        guard let window = window , let rootViewController = window.rootViewController else {
            return
        }
        
        let alert = self.alertUtil.getAlert()
        rootViewController.blurEffect()
        rootViewController.present(alert, animated: true)
    }
}

