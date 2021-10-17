//
//  BaseAnimationObserver.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 16.10.2021.
//

import Foundation


/**
    currentAngle - angle from last rotation update, to newRotation update, allways from 0 to 360
     dirty angle - angle from 0 to max value, can be > 360
 */
protocol BaseAnimationObserverOnUpdate {
    func onUpdate(index: Double, currentAngle: Double, dirtyAngle: Double) -> Void
}

class BaseAnimationObserver {
    
    
    fileprivate var displayLink: CADisplayLink?
    fileprivate var iterationsCount: Double = 0
    fileprivate var oldAngle: Double = 0
    fileprivate var newAngle: Double = 0
    fileprivate var count: Double = 0
    fileprivate var angleCounter: Double = 0.0
    fileprivate var dirtyAngle: Double = 0.0
    fileprivate var step = 0.0
    
    var delegate: BaseAnimationObserverOnUpdate? = nil
    
    func start(duration: Double, oldAngle: Double, newAngle: Double){
        self.count = 0.0
        self.angleCounter = oldAngle
        self.dirtyAngle = 0
        self.iterationsCount = Double(duration * 60.0)
        self.oldAngle = oldAngle
        self.newAngle = newAngle
        self.step = newAngle  / iterationsCount
        self.displayLink = CADisplayLink(target: self, selector: #selector(update))
        self.displayLink?.add(to: .current, forMode: .default)
    }
    
    
    @objc
    private func update() {
        
        self.count += 1
        self.angleCounter += step
        self.dirtyAngle += step
        
        if(angleCounter > 360){
            angleCounter -= 360
        }
        
        self.delegate?.onUpdate(index: count, currentAngle: angleCounter, dirtyAngle: dirtyAngle)
    }
    
    func stop(){
        self.displayLink?.remove(from: .current, forMode: .default)
        self.displayLink = nil
    }
    
}
