//
//  BaseAnimationObserver.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 16.10.2021.
//

import Foundation

/**
    @angleFromBegin - changes from 0 ... to wantedAngle
    @angleCurrent - current offset, changes between wantedAngle and old anlge, where min is storedValue, max: wanted ( new value)
 */
protocol BaseAnimationObserverOnUpdate {
    func onUpdate(angleFromBegin: Double, angleCurrent: Double) -> Void
}

class BaseAnimationObserver {
    
    
    fileprivate var displayLink: CADisplayLink?
    fileprivate var duration: Double = 0
    fileprivate var iterationsCount: Double = 0
    fileprivate var oldAngle: Double = 0
    fileprivate var newAngle: Double = 0
    fileprivate var count: Double = 0
    
    var delegate: BaseAnimationObserverOnUpdate? = nil
    
    func start(duration: Double, oldAngle: Double, newAngle: Double){
        self.count = 0.0
        self.iterationsCount = Double(duration * 60.0)
        self.oldAngle = oldAngle
        self.newAngle = newAngle
        self.displayLink = CADisplayLink(target: self, selector: #selector(update))
        self.displayLink?.add(to: .current, forMode: .default)
    }
    
    
    @objc
    private func update() {
        
        self.count += 1
        let animationStep: Double = count * (newAngle / iterationsCount)
        let angleChangesStep: Double = ( count * ( (newAngle - oldAngle) / iterationsCount) + oldAngle)
        
        if(animationStep > newAngle){
            return
        }
        
        self.delegate?.onUpdate(angleFromBegin: animationStep, angleCurrent: angleChangesStep)
    }
    
    func stop(){
        self.displayLink?.remove(from: .current, forMode: .default)
        self.displayLink = nil
    }
    
}
