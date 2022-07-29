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

let notificationIdentifier = "TimerNotification"

/**
    bad solution:  UIApplication.shared.isIdleTimerDisabled = true
 */
class TimerUtil{
    
    
    
    private var notificationUtil: NotificationUtil
    
    private var maxTimeInMinutes = DEFAULT_MAX_TIME
    
    private var timer: Timer? = nil
    
    private var timerValue = 0
    
    weak var delegate: TimerUtilDelegate? = nil
    
    
    init(notificationUtil: NotificationUtil){
        self.notificationUtil = notificationUtil
    }
    
   
    func setMaxTime(maxTimeInMinutes: Int){
        self.maxTimeInMinutes = maxTimeInMinutes
    }
    
    #warning("maybe delete later")
    func hasDeliveredNotification(callback: @escaping (_ itHas: Bool) -> Void){
        self.notificationUtil.hasDeliveredNotification(callback: callback)
    }
    
    #warning("maybe delete later")
    func clearDeliveredNotifications(){
        self.notificationUtil.clearDeliveredNotifications()
    }
    
    func startTimer(){
        self.notificationUtil.sceduleNotification(maxTimeInMinutes: maxTimeInMinutes)
        self.timerValue = maxTimeInMinutes.toSeconds()
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
    }
    
    func stopTimer(){
        self.notificationUtil.cancelNotification()
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

}

