//
//  ElapsedTimeUtil.swift
//  RS
//
//  Created by ICoon on 29.07.2022.
//

import Foundation


#warning("need implementation")
class ElapsedTimeUtil{
    
    
    let storage: UserDefaultStorage
    
    init(storage: UserDefaultStorage){
        self.storage = storage
    }
    
    /**
        storage methods , read write time from start timer
     */
    func saveStartTimerTime(){
       
    }
    
    func clearStartTimerTime(){
     
    }
    
    func getElapsedTime() -> Int{
       
        return 0
    }
    
    func isTimerStarted() -> Bool{
      
        return false
    }
}
