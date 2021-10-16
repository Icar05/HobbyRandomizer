//
//  BaseAnimationObserver.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 16.10.2021.
//

import Foundation


protocol BaseAnimationObserverOnUpdate {
    func onUpdate(value: Double) -> Void
}

class BaseAnimationObserver {
    
    var delegate: BaseAnimationObserverOnUpdate? = nil
    fileprivate var displayLink: CADisplayLink?
    var counter: Double = 0
    
    func start(){
        counter = 0
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink?.add(to: .current, forMode: .default)
    }
    
    
    @objc
    private func update() {
        self.delegate?.onUpdate(value: counter)
        self.counter += 1
    }
    
    func stop(){
        self.displayLink?.remove(from: .current, forMode: .default)
        self.displayLink = nil
    }
    
}
