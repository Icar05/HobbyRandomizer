//
//  PlaySoundUtil.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 16.10.2021.
//

import Foundation

class PlaySoundUtil {
    
    fileprivate  static var needPlay = true
    
    func play(){
        while PlaySoundUtil.needPlay {
            print("play cool song ..")
        }
    }
    
    func stop(){
        PlaySoundUtil.needPlay = false
    }
    
    /**
     AudioServicesPlaySystemSoundWithCompletion(1157, nil);
     //            print(" -- current ... \(play)")
     //        }
     */
}
