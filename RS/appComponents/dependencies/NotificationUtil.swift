//
//  TimerBackgroundUtil.swift
//  RS
//
//  Created by ICoon on 29.07.2022.
//

import Foundation

class NotificationUtil{
    
    
    
    private let showLogs = false
    
    private let log = "NotificationUtil"
    
    
    
    
    func hasDeliveredNotification(callback: @escaping (_ itHas: Bool) -> Void){
        UNUserNotificationCenter.current().getDeliveredNotifications { notifications in
          
            let sortedNotification = notifications.filter{ $0.request.identifier == notificationIdentifier }
            
            self.printLog("count: raw: \(notifications.count), sorted: \(sortedNotification.count)")
            
            callback(sortedNotification.count > 0)
            
        }
    }
    
    /**
        check notification permissins
     */
    func checkNotificationPermission(doIfNotPermitted: @escaping () -> Void){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (bool, error) in
            self.printLog("Permission -> permitted: \(bool), error: \(String(describing: error))")
            
            if(!bool){
               doIfNotPermitted()
            }
        }
    }
    
    /**
        register and cancel notifications
     */
    
    func clearDeliveredNotifications(){
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        self.printLog("clearDeliveredNotifications")
    }
    
    func cancelNotification(){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationIdentifier])
        self.printLog("cancelNotification")
    }
    
    func sceduleNotification(maxTimeInMinutes: Int){
    
        let soundName = UNNotificationSoundName("\(timerSound.rawValue).mp3")
        let sound = UNNotificationSound(named: soundName)
        let time: Double = Double(maxTimeInMinutes.toSeconds())
        let content =  UNMutableNotificationContent()
            content.body = Translations.Timer.timeHasGone
            content.sound = sound
                    
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
        let request = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigger)
        
        printLog("sound: \(sound)")
             
        
        UNUserNotificationCenter.current().add(request) { [self] (error) in
            if (error != nil) {
                printLog("sceduleNotification: error: \(String(describing: error))")
            } else {
                printLog("sceduleNotification: time \(maxTimeInMinutes) minutes")
            }
        }
    }
    
    private func printLog(_ value: String){
        if(showLogs){
            print("\(log): \(value)")
        }
    }
    
}
