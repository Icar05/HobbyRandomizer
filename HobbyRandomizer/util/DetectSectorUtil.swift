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
    
    
    fileprivate var sectorSize: Double = 0
    
    fileprivate var nearestSector: Double = 0
    
    var delegate: DetectSectorUtilDelegate? = nil

    
    func setup(sectorSize: Double){
        self.sectorSize = sectorSize
    }
    
    func setNearestSector(nearestSector: Double){
        self.nearestSector = nearestSector
    }
    
    func update(currentAngle: Double){
//        if(currentAngle >= nearestSector){
//            self.delegate?.onDetectSector()
//            self.nearestSector += sectorSize
//        }
    }
    
}
