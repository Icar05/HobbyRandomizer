//
//  TimerView.swift
//  RS
//
//  Created by ICoon on 27.07.2022.
//

import UIKit

class TimerView: UIView {

    
    private var displayView: TimerDisplayView = TimerDisplayView()
    
    private var sizeOfView: CGFloat = 300
    

    
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
    
    
//    override var bounds: CGRect {
//        didSet {
//            self.frame = CGRect(x: 0, y: 0, width: sizeOfView, height: sizeOfView)
//        }
//    }
    
//    override func draw(_ rect: CGRect) {
//        let outerCircleSize =  self.sizeOfView - (2 * circlePadding)
//        self.drawCircle(size: outerCircleSize, color: UIColor.black)
//
//    }
    
    
    fileprivate func setup(){
        self.layer.bounds.size = CGSize(width: CGFloat(sizeOfView), height: CGFloat(sizeOfView))
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(displayView)
        
        self.backgroundColor = UIColor.red
    }
    

}
