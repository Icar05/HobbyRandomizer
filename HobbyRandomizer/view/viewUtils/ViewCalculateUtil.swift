//
//  ViewCalculateUtil.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 05.11.2021.
//

import UIKit

class ViewCalculateUtil{
    
    
    
    fileprivate var angles = [AngleOfSector]()
    
    fileprivate  var storedAngle: Double = 0
    
    
    func deg2rad(_ number: Double) -> CGFloat {
        let value = number * .pi / 180
        return CGFloat(value)
    }
    
    func calculateFontSize(itemsCount: Int) ->  CGFloat{
        let maxFontSize = 30
        let howMuch = itemsCount / maxFontSize
        let clearHowMuch = howMuch > 3 ? 3: howMuch
        let offset = howMuch < 2 ? 5 : 0
        return CGFloat(maxFontSize - (clearHowMuch * 10)) - CGFloat(offset)
    }
    
    func searchAngle(index: Int) ->  Double{
        
        let fullWinnerAngle = 810.0
        let currentAngleOfSelectedSector = self.angles[index].getMiddleAngle()
    
        let difference =  fullWinnerAngle - currentAngleOfSelectedSector
        let differenceWithStartOffset = difference - storedAngle
        
        return differenceWithStartOffset
    }
    
    func searchAngleForCasino(index: Int) -> Double {
        
        let angleOfWantedSector = self.angles[index].getMiddleAngle()
        let finalPosition = angleOfWantedSector + ( 360 * 2)
        let currentAngle = getStoredAngle() + 90
        
        return finalPosition - currentAngle
    }
  
    
    func searchDistanceToNearestSector() -> Double{
        
        var nearestDistance: Double = -1
                
        for index in stride(from: angles.count - 1, through: 0, by: -1) {
            let maxValueAngleOfSector = angles[index].maxAngle
            let withOffset: Double = maxValueAngleOfSector + storedAngle
            let clearOffset = roundAngleTo360(value: withOffset)
            
            if(clearOffset < 90){
                if(clearOffset > nearestDistance){
                    nearestDistance = clearOffset
                }
            }
        }
                
        return 90 - nearestDistance
    }
    
    func updateNewAngle(angle: Double){
        self.storedAngle += angle
        
        if(self.storedAngle > 360){
            while storedAngle > 360 {
                self.storedAngle -= 360
            }
        }
    }
    
    
    
    func clearAngles(){
        self.angles = [AngleOfSector]()
        self.storedAngle = 0
    }
    
    func appendAngle(angle: AngleOfSector){
        self.angles.append(angle)
    }
    
    func getStoredAngle() -> Double{
        return storedAngle
    }
    
    func getStartAngle(index: Int) ->  Double{
        return self.angles[index].minAngle
    }
    
    
    fileprivate func roundAngleTo360(value: Double) -> Double{
        var newValue = value
        if(newValue > 360 && newValue - 360 > 0.1){
            while newValue > 360 {
                newValue -= 360
            }
        }
        
        return newValue
    }
    
}
