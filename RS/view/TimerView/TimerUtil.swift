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
    
    private let showLogs = true
    
    private let log = "TimerUtil"
    
    weak var delegate: TimerUtilDelegate? = nil
    
    
    
    init(notificationUtil: NotificationUtil){
        self.notificationUtil = notificationUtil
        
        NotificationCenter.default.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(appGoneToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
   
    func setMaxTime(maxTimeInMinutes: Int){
        self.maxTimeInMinutes = maxTimeInMinutes
    }
    
    func startTimer(){
        self.notificationUtil.sceduleNotification(maxTimeInMinutes: maxTimeInMinutes)
        self.timerValue = maxTimeInMinutes.toSeconds()
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
        
        printLog("startTimer")
    }
    
    func stopTimer(){
        self.notificationUtil.cancelNotification()
        self.timer?.invalidate()
        self.timer = nil
        self.delegate?.onTimerStop()
        
        printLog("stopTimer")
    }
    
    @objc func timerUpdate() {
        self.timerValue -= 1
        self.delegate?.onTimerUpdate(value: timerValue)
        
        if(timerValue == 0){
            self.delegate?.onTimerFinished()
            self.stopTimer()
        }
        
        printLog("timerUpdate")
        
    }
    
    @objc func appGoneToBackground() {
        printLog("app in background!")
    }
    
    @objc func appCameToForeground() {
        printLog("app in foreground!")
        
        self.notificationUtil.hasDeliveredNotification(callback: {itHas in
            if(itHas){
                self.timerHasFinishedInBackground()
            } else{
                self.timerHasUpdatedInBackground()
            }
        })
    }
    
    
    //we don't have any messages
    //timer can be still running, or state can be already handled
    private func timerHasUpdatedInBackground(){
        #warning("detect if timer is started (variable?)")
        
        printLog("timerHasUpdatedInBackground")
        // can be possible getting there after timer finished work, and it will be handled,
        // so wanted check if timer is stopped and finished
        
        // get ellapsed time
        // update timer util
        // get callback from timer util to update views
    }
    
    //we have delivered message, we have to notify timer about finish
    private func timerHasFinishedInBackground(){
        printLog("timerHasFinishedInBackground")
        DispatchQueue.main.async {
            self.stopTimer()
            self.notificationUtil.clearDeliveredNotifications()
        }
    }

    
    private func printLog(_ value: String){
        if(showLogs){
            print("\(log): \(value)")
        }
    }
}

