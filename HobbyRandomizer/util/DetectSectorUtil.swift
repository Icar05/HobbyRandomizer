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
            
    fileprivate var leftToBorder: Double = 0
    
    var delegate: DetectSectorUtilDelegate? = nil

    
    func setup(sectorSize: Double){
        self.sectorSize = sectorSize
    }
    
    func distanceToNearesSector(leftToBorder: Double){
        self.leftToBorder = leftToBorder
    }
    
    func update(currentAngle: Double){
        if(currentAngle > leftToBorder){
            self.delegate?.onDetectSector()
            self.leftToBorder += sectorSize
        }
    }
    
}
