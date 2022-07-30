//
//  TimerDisplayLayerView.swift
//  RS
//
//  Created by ICoon on 30.07.2022.
//

import UIKit

@IBDesignable
class TimerDisplayLayerView: UIView, TimerDisplay {

    
   
    
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var startPoint = CGFloat(-Double.pi / 2)
        private var endPoint = CGFloat(3 * Double.pi / 2)

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

    
    fileprivate func setup(){
        self.layer.bounds.size = CGSize(width: CGFloat(sizeOfView), height: CGFloat(sizeOfView))
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.yellow
        createCircularPath()
    }
    
    
    func progressAnimation(duration: TimeInterval) {
            // created circularProgressAnimation with keyPath
            let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
            // set the end time
            circularProgressAnimation.duration = duration
            circularProgressAnimation.toValue = 1.0
            circularProgressAnimation.fillMode = .forwards
            circularProgressAnimation.isRemovedOnCompletion = false
            progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
        }
    
    func createCircularPath() {
            // created circularPath for circleLayer and progressLayer
        
            let arcCenter = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
            let circularPath = UIBezierPath(arcCenter: arcCenter,
                                            radius: 80,
                                            startAngle: startPoint,
                                            endAngle: endPoint,
                                            clockwise: true)
        
        
            // circleLayer path defined to circularPath
            circleLayer.path = circularPath.cgPath
            // ui edits
            circleLayer.fillColor = UIColor.clear.cgColor
            circleLayer.lineCap = .round
            circleLayer.lineWidth = 20.0
            circleLayer.strokeEnd = 1.0
            circleLayer.strokeColor = UIColor.white.cgColor
            // added circleLayer to layer
            layer.addSublayer(circleLayer)
            // progressLayer path defined to circularPath
            progressLayer.path = circularPath.cgPath
            // ui edits
            progressLayer.fillColor = UIColor.clear.cgColor
            progressLayer.lineCap = .round
            progressLayer.lineWidth = 10.0
            progressLayer.strokeEnd = 0
            progressLayer.strokeColor = UIColor.green.cgColor
            // added progressLayer to layer
            layer.addSublayer(progressLayer)
        }
    
    
    func setSingleUpdaterColor(value: Bool) {
        
    }
    
    func setMaxTimeInSeconds(maxTimeInSeconds: Int) {
        
    }
    
    func updateCurrentValue(current: Int, max: Int) {
//        progressAnimation(duration: 3.0)
        
        print("value: \(current), max: \(max)")
//        progressLayer.strokeEnd = CGFloat(0.5)
    }
    
    func updateInnerColor(color: UIColor) {
        
    }
    
    func updateOutColor(color: UIColor) {
        
    }

}
