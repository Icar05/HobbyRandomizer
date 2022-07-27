//
//  TimerDisplayView.swift
//  RS
//
//  Created by ICoon on 27.07.2022.
//

import UIKit

@IBDesignable
class TimerDisplayView: UIView {
   
    
    
    
    private let viewDrawUtil = ViewDrawUtil()
    
    private let viewCalculateUtil = ViewCalculateUtil()
    
    private var sizeOfView: CGFloat = 250
    
    private var circlePadding: CGFloat = 10
    
    private var outCircleColor = UIColor.black
    
    private var innerCircleColor = UIColor.white
    
    private var updaterColor = UIColor.systemGreen
    
    private var currentAngle: Double = 225
    
    private var maxTimeInSeconds = 0
    
    private var singleUpdaterColor = false
    
    private var currentValue = 0
    
    

    
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
    
    override func draw(_ rect: CGRect) {
        let outerCircleSize =  self.sizeOfView - (2 * circlePadding)
        let innerCircleSize = outerCircleSize - circlePadding - 3
        self.drawCircle(size: outerCircleSize, color: outCircleColor)
        self.drawSector()
        self.drawCircle(size: innerCircleSize , color: innerCircleColor)
    }
    
    func setMaxTimeInSeconds(maxTimeInSeconds: Int){
        self.maxTimeInSeconds = maxTimeInSeconds
    }
    
    func setPreferences(preferences: AppPrefferencesModel){
        self.setMaxTimeInSeconds(maxTimeInSeconds: preferences.timerMinutes.toSeconds())
        self.singleUpdaterColor = preferences.timerSingleColor
    }
    
    func updateOutColor(color: UIColor){
        self.outCircleColor = color
        self.setNeedsDisplay()
    }
    
    func updateCurrentValue(value: Int){
        self.currentValue = value
        self.setNeedsDisplay()
    }
    
    func updateInnerColor(color: UIColor){
        self.innerCircleColor = color
        self.setNeedsDisplay()
    }
    
    fileprivate func setup(){
        self.layer.bounds.size = CGSize(width: CGFloat(sizeOfView), height: CGFloat(sizeOfView))
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clear
    }
    
    private func drawCircle(size: CGFloat, color: UIColor, point: CGPoint) -> CAShapeLayer{
        return self.viewDrawUtil.drawCircle(size: size, color: color, point: point)
    }
    
    private func drawCircle(size: CGFloat, color: UIColor){
        self.viewDrawUtil.drawCircle(size: size, color: color, sizeOfView: sizeOfView)
    }
    
    private func drawSector(){
        if(maxTimeInSeconds == 0 || currentValue == 0){
            return
        }
        
        let currentAngle: Double = Double((360 * (maxTimeInSeconds - currentValue)) / maxTimeInSeconds)
        let color = getColor(angle: currentAngle)
    
        self.drawSector(currentAngle: currentAngle, color: color)
    }
    
    private func getColor(angle: Double) -> UIColor{
        if(singleUpdaterColor) {
            return updaterColor
        }
        
        if(angle < 120){
            return UIColor.coolGreen!
        }else if (angle < 240){
            return UIColor.coolOrange!
        }else{
            return UIColor.coolRed!
        }
    }
    
    private func drawSector(currentAngle: Double, color: UIColor){
        
        let offset: Double = 90
        
        self.viewDrawUtil.drawSector(
            viewCalculateUtil.deg2rad(-offset),
            viewCalculateUtil.deg2rad(currentAngle - offset),
            color,
            sizeOfView: sizeOfView,
            circlePadding: circlePadding / 2)
    }
    
}
