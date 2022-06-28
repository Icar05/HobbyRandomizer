//
//  SoundUtil.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import Foundation
//import AudioToolbox.AudioServices
import AVFoundation


struct SoundsForTest{
    static let picker = 1157
    static let testing = 1050
    static let nice = 1057
    static let double = 1160
}

class SoundUtil{
    
    
    fileprivate var sound: Int = SoundsForTest.nice
    
    private let enable: Bool
    
    private let volume: Float
    
    private var player: AVAudioPlayer? = nil
    
    
    init(enable: Bool, volume: Float){
        self.enable = enable
        self.volume = volume
    }
    
    private func initPlayer(){
        if(enable){
            guard  let scanSoundPath = Bundle.main.path(forResource: "beep", ofType: "caf") else{
                return
            }
            
            let scanSoundURL = URL(fileURLWithPath: scanSoundPath)
            do {
                self.player  = try AVAudioPlayer(contentsOf: scanSoundURL)
                self.player?.volume = volume
            } catch let error {
               print("Player: error: \(error) ")
            }
        }
    }
    
    func play(){
        self.player?.play()
    }
    
}
