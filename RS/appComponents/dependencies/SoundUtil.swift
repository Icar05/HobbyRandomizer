//
//  SoundUtil.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import Foundation
import AVFoundation



enum SoundCaf: String{
    case Open = "Open"
    case Click = "Click"
    case OldAlarm = "old-alarm"
    case EvilAlarm = "evil-alarm"
    case ModernAlarm = "modern-alarm"
    case StandartAlarm = "standart-alarm"
}

let timerSound = SoundCaf.EvilAlarm

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
                                    
            do {
                guard let path = Bundle.main.path(forResource: sound.rawValue, ofType: "mp3") else {
                    print("Sound file not found")
                    return
                }
                
                let storedURL = URL(fileURLWithPath: path)
                self.player   = try AVAudioPlayer(contentsOf: storedURL, fileTypeHint: AVFileType.mp3.rawValue)
                self.player?.volume = volume
            } catch let error {
                print("Player: error: \(error) ")
            }
        }
    }
    
    func stop(){
        player?.stop()
    }
    
    func play(){
        guard let player = player else {
            return
        }

        player.play()
    }
    
}
