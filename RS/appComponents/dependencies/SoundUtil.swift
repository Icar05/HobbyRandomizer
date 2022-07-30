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
}

let timerSound = SoundCaf.Click

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
            
            print("path: \(scanSoundURL)")
            
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
    
    func play(){
        guard let player = player else {
            return
        }

        player.play()
    }
    
}
