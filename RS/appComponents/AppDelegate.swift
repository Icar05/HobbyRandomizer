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
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.navigator.setupInitialViewController(window: window!)
        self.testUtil = TestUtil(fileUtil: fileUtil)
        self.testUtil?.startTest()
        
        self.setupNotifications()
       
        
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
    
   
    /**
        notifications
     */
    private func setupNotifications(){
        // Setup Notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (bool, error) in
            print("UNUserNotificationCenter Permission -> permitted: \(bool), error: \(String(describing: error))")
            
            if(!bool){
                DispatchQueue.main.async {
                    self.handleDisabledPermission()
                }
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

