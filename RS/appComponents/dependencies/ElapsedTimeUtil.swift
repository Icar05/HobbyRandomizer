//
//  ElapsedTimeUtil.swift
//  RS
//
//  Created by ICoon on 29.07.2022.
//

import Foundation



class ElapsedTimeUtil{
    
    
    let storage: UserDefaultStorage
    
    
    init(storage: UserDefaultStorage){
        self.storage = storage
    }
    
    func saveStartTimerTime(){
        self.storage.saveTime(time: getTime())
    }
    
    func clearStartTimerTime(){
        self.storage.clearTime()
    }
    
    func getCurrentTime() -> Int{
        return self.storage.getTime()
    }
    
    func getElapsedTime() -> Int{
        return (getTime() - self.storage.getTime() ) / 1000
    }
    
    private func getTime() -> Int {
        return Int(Date().timeIntervalSince1970 * 1000)
    }
    
}
