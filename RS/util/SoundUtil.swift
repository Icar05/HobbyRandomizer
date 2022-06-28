//
//  SoundUtil.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import Foundation
import AVFoundation


struct SoundsForTest{
    static let Tink = "/System/Library/Audio/UISounds/Tink.caf"
}

/**
  https://github.com/TUNER88/iOSSystemSoundsLibrary
 */
class SoundUtil{
    
    
    fileprivate var sound: String = SoundsForTest.Tink
    
    private let enable: Bool
    
    private let volume: Float
    
    private var player: AVAudioPlayer? = nil
    
    
    init(enable: Bool, volume: Float){
        self.enable = enable
        self.volume = volume
        self.initPlayer()
    }
    
    private func initPlayer(){
        if(enable){

            let scanSoundURL = URL(fileURLWithPath: sound)
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
