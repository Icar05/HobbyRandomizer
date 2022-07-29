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
        
        print("app delegate launch")
                
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.navigator.setupInitialViewController(window: window!)
        self.testUtil = TestUtil(fileUtil: fileUtil)
        self.testUtil?.startTest()
        
        self.setupNotifications()
       
        
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        self.checkMessages()
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
    
   

}

// notifications
extension AppDelegate: UNUserNotificationCenterDelegate{
    
       @available(iOS 10.0, *)
       func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
           
           print("UNUserNotificationCenter ->  willPresent notification")
           completionHandler([.alert,.sound])

       }

       @available(iOS 10.0, *)
       func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
           
           print("UNUserNotificationCenter ->  didReceive response")
           
           NotificationCenter.default.post(name: .timerNotification , object: nil, userInfo: response.notification.request.content.userInfo)
           
           completionHandler()
       }
    
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
                
        UNUserNotificationCenter.current().delegate = self
    }
    
    private func checkMessages(){
        print("check messages...")
        
        UNUserNotificationCenter.current().getDeliveredNotifications { notifications in
            
            print("notifications count: \(notifications.count)")
            if(notifications.count > 0){
                NotificationCenter.default.post(name: .timerNotification , object: nil, userInfo: nil)
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
