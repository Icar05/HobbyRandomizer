//
//  TimerUtil.swift
//  RS
//
//  Created by ICoon on 27.07.2022.
//

import Foundation
import AVKit

public protocol TimerUtilDelegate: NSObject{
    func onTimerUpdate(value: Int)
    func onTimerFinished()
    func onTimerStop()
}

/**
    bad solution:  UIApplication.shared.isIdleTimerDisabled = true
 */
class TimerUtil{
    
    
    
    private let identifier = "TimerNotification"
    
    private var maxTimeInMinutes = 0
    
    private var timer: Timer? = nil
    
    private var timerValue = 0
    
    weak var delegate: TimerUtilDelegate? = nil
    
    
   
    func setMaxTime(maxTimeInMinutes: Int){
        self.maxTimeInMinutes = maxTimeInMinutes
    }
    
    func startTimer(){
        self.registerNotification()
        self.timerValue = maxTimeInMinutes.toSeconds()
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
    }
    
    func stopTimer(){
        self.removeNotification()
        self.timer?.invalidate()
        self.timer = nil
        self.delegate?.onTimerStop()
    }
    
    @objc func timerUpdate() {
        self.timerValue -= 1
        self.delegate?.onTimerUpdate(value: timerValue)
        
        if(timerValue == 0){
            self.delegate?.onTimerFinished()
            self.stopTimer()
        }
    }
    
    private func removeNotification(){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    private func registerNotification(){
        
        let soundName = UNNotificationSoundName("Tock.caf")
        let sound = UNNotificationSound(named: soundName)
        let time: Double = Double(maxTimeInMinutes.toSeconds())
        let content =  UNMutableNotificationContent()
            content.body = Translations.Timer.timeHasGone
            content.sound = sound
                    
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        print("sound: \(sound)")
             
        
        UNUserNotificationCenter.current().add(request) { [self] (error) in
//            if (error != nil) {
//                print("UNUserNotificationCenter: error: \(String(describing: error))")
//            } else {
//                print("UNUserNotificationCenter: Add request with time: \(maxTimeInMinutes) minutes -> Success!")
//            }
        }
    }
}

