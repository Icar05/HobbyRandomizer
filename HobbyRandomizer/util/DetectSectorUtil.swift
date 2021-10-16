//
//  DetectSectorUtil.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 16.10.2021.
//

import UIKit

protocol DetectSectorUtilDelegate {
    func onDetectSector()
}

class DetectSectorUtil {
    
    
    fileprivate var sectorAngle: Double = 0
    
    fileprivate var detectSectorCounter: Double = 0
    
    fileprivate var sectorTimeOffset: Double = 0
    
    fileprivate var animationDuration: Double = 0
    
    var delegate: DetectSectorUtilDelegate? = nil

    
    
    
    func setup(sectorAngle: Double, animationDuration: Double){
        self.sectorAngle = sectorAngle
        self.animationDuration = animationDuration
        self.detectSectorCounter = 0
    }
    
    func updateNewAngleValue(newAngle: Double){
        self.sectorTimeOffset = Double(newAngle) / Double(animationDuration * 60)
    }
    
    func itarate(){
        self.detectSectorCounter += sectorTimeOffset
        
        if(self.detectSectorCounter >= sectorAngle){
            self.delegate?.onDetectSector()
            self.detectSectorCounter = 0
        }
    }
    
}
