//
//  TimerSquereDisplay.swift
//  RS
//
//  Created by ICoon on 30.07.2022.
//

import UIKit

@IBDesignable
class TimerSquereDisplay: UIView, TimerDisplay {
 
    
   

    private var sizeOfView: CGFloat = 250

    
    override func prepareForInterfaceBuilder(){
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    override var bounds: CGRect {
        didSet {
            self.frame = CGRect(x: 0, y: 0, width: sizeOfView, height: sizeOfView)
        }
    }
    
    private func setup(){
        self.layer.bounds.size = CGSize(width: CGFloat(sizeOfView), height: CGFloat(sizeOfView))
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.orange
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    
    func setSingleUpdaterColor(value: Bool) {
        
    }
    
    func setMaxTimeInSeconds(maxTimeInSeconds: Int) {
        
    }
    
    func updateCurrentValue(current: Int, max: Int) {
        
    }
    
    func updateInnerColor(color: UIColor) {
        
    }
    
    func updateCircleColor(color: UIColor) {
        
    }
}
