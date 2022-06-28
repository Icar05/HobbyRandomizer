//
//  SoundUtil.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import Foundation
import AudioToolbox.AudioServices


struct SoundsForTest{
    static let picker = 1157
    static let testing = 1050
    static let nice = 1057
    static let double = 1160
}

class SoundUtil{
    
    
    fileprivate var sound: Int = SoundsForTest.nice
    
    init(){
//        AudioServicesPlaySystemSoundWithCompletion(SystemSoundID(sound), nil)
    }
//
//    - (void)initializePlayer
//    {
//        NSString *scanSoundPath = [[NSBundle mainBundle] pathForResource:@"beep"
//                                                          ofType:@"caf"];
//        NSURL *scanSoundURL = [NSURL fileURLWithPath:scanSoundPath];
//        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:scanSoundURL
//                                                               error:nil];
//        self.player.volume = 0.5;
//    }
    
    
}
