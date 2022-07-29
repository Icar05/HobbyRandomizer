//
//  SoundUtil.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import Foundation
import AVFoundation


/**
 https://github.com/TUNER88/iOSSystemSoundsLibrary
 https://gist.github.com/ParityError/5a691e0cb769b1871f9999293bb22b99
 */

enum SoundCaf: String{
    case Tink = "/System/Library/Audio/UISounds/Tink.caf"
    case Tock = "/System/Library/Audio/UISounds/Tock.caf"
    case Beep = "/System/Library/Audio/UISounds/SIMToolkitGeneralBeep.caf"
    case Negative = "/System/Library/Audio/UISounds/SIMToolkitNegativeACK.caf"
    case End = "/System/Library/Audio/UISounds/end_record.caf"
    case Timer = "/System/Library/Audio/UISounds/nano/Alarm_Nightstand_Haptic.caf"
}

class SoundUtil{
    
        
    private let enable: Bool
    
    private let volume: Float
    
    private let sound: SoundCaf
    
    private var player: AVAudioPlayer? = nil
    
    
    init(enable: Bool, volume: Float, sound: SoundCaf){
        self.enable = enable
        self.volume = volume
        self.sound = sound
        self.initPlayer()
    }
    
    private func initPlayer(){
        if(enable){
            
            let scanSoundURL = URL(fileURLWithPath: sound.rawValue)
            do {
                self.player  = try AVAudioPlayer(contentsOf: scanSoundURL)
                self.player?.volume = volume
            } catch let error {
                print("Player: error: \(error) ")
            }
        }
    }
    
    func play(){
        guard let player = player else {
            return
        }
        
        if(player.isPlaying){
            player.stop()
        }
        
        player.play()
    }
    
}
