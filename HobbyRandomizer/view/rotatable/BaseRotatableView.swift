//
//  BaseRotatableView.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 14.10.2021.
//

import UIKit

typealias RandomizerCallback = (_ winner: Int, _ winnerColor: UIColor) -> Void


class BaseRotatableView: UIView, CAAnimationDelegate {
    
    
    
    fileprivate  var path = UIBezierPath()
    
    fileprivate var angles = [AngleOfSector]()
    
    fileprivate  var newAngle: Double = 0
    
    internal var sizeOfView: CGFloat = 300
    
    internal  let circlePadding: CGFloat = 10
    
    internal var callback: RandomizerCallback? = nil
    
    
    
    
    
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
    
    
    func setup(){
        self.layer.bounds.size = CGSize(width: CGFloat(sizeOfView), height: CGFloat(sizeOfView))
        self.layer.masksToBounds = true
        self.childSetup()
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let winnerIndex = searchWinnerSector()
        self.didFoundWinner(value: winnerIndex)
    }
    
    
    
    /*
     INHERIT OVERRIDE ZONE
     */
    func childSetup(){}
    
    func didFoundWinner(value: Int){}
    
    func onDrawSection(startAngle: Double, endAngle: Double, i: Int, angleSector: Double){}
    
    func getColorForSection(sectionId: Int) -> UIColor {
        return UIColor.white
    }
    
    func getAttributedString(fontSize: CGFloat, item: Int) -> NSAttributedString {
        return NSAttributedString()
    }
    
    
    /*
     PARENT METHODS
     */
    internal func drawCircle(size: CGFloat, color: UIColor){
        color.setFill()
        let point = (self.sizeOfView - size) / 2
        self.path = UIBezierPath(ovalIn:CGRect(x: point, y: point, width: size, height: size))
        self.path.fill()
    }
    
    internal func drawCircle(size: CGFloat, color: UIColor, point: CGPoint){
        color.setFill()
        self.path = UIBezierPath(ovalIn:CGRect(x: point.x, y: point.y, width: size, height: size))
        self.path.fill()
    }
    
    internal func prepareSectors(itemsCount: Int){
        let minAngle = 0
        let maxAngle: Double = 360
        let sectorAngle: Double = maxAngle / Double(itemsCount)
        let fontSize = calculateFontSize(itemsCount: itemsCount)
        var startAngle: Double = Double(minAngle)
        var endAngle: Double = sectorAngle
        
        
        for i in 0...itemsCount - 1{
            
            self.drawSector(startAngle, endAngle,  getColorForSection(sectionId: i))
            self.angles.append(AngleOfSector(minAngle: startAngle, maxAngle: endAngle))
            
            let middleAngle: Double = (startAngle + endAngle) / 2
            let string = getAttributedString(fontSize: fontSize, item: i)
            drawText(angle: middleAngle, string: string)
            
            //increment next value
            startAngle += sectorAngle
            endAngle += sectorAngle
            
        }
    }
    
    internal func clearAngles(){
        self.angles = [AngleOfSector]()
        self.newAngle = 0
    }
    
    internal func rotate(){
        let randonAngle =  arc4random_uniform(361) + 360
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = Double(randonAngle) * Double.pi / 180.0
        rotateAnimation.duration = 1
        rotateAnimation.repeatCount = 0
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.fillMode = CAMediaTimingFillMode.forwards
        rotateAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        rotateAnimation.delegate = self
        
        self.updateNewAngleValue(angle: Double(randonAngle))
        
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    internal func getStartAngle(index: Int) ->  Double{
        return self.angles[index].minAngle
    }
    
    internal func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
    /**
     PRIVATE ZONE
     */
    fileprivate func drawText(angle: Double, string: NSAttributedString){
        let centerPoint = CGPoint(x: self.sizeOfView / 2, y: self.sizeOfView / 2)
        let textSize: CGSize = string.size()
        let radius: CGFloat = (self.sizeOfView / 2 ) - textSize.width - (circlePadding * 2)
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        let t: CGAffineTransform = CGAffineTransform(translationX: centerPoint.x, y: centerPoint.y)
        
        let r: CGAffineTransform = CGAffineTransform(rotationAngle: CGFloat(deg2rad(angle)))
        context.concatenate(t)
        context.concatenate(r)
        
        let newPoint = CGPoint(x: radius-textSize.width/2, y: -textSize.height/2)
        string.draw(at: newPoint)
        
        context.concatenate(r.inverted())
        context.concatenate(t.inverted())
    }
    
    fileprivate func drawSector(_ startAngle: Double, _ endAngle: Double, _ color: UIColor){
        
        let center = sizeOfView / 2
        let viewCenter = CGPoint(x: self.sizeOfView / 2, y: self.sizeOfView / 2)
        let radius = center - (circlePadding * 2) //height of sector
        
        color.setFill()
        
        self.path = UIBezierPath()
        self.path.move(to: viewCenter)
        self.path.addArc(
            withCenter: viewCenter,
            radius: CGFloat(radius),
            startAngle: CGFloat(deg2rad(Double(startAngle))),
            endAngle: CGFloat(deg2rad(Double(endAngle))),
            clockwise: true
        )
        
        self.path.close()
        self.path.fill()
    }
    
    fileprivate func calculateFontSize(itemsCount: Int) ->  CGFloat{
        let maxFontSize = 30
        let howMuch = itemsCount / maxFontSize
        let clearHowMuch = howMuch > 3 ? 3: howMuch
        let offset = howMuch < 2 ? 5 : 0
        return CGFloat(maxFontSize - (clearHowMuch * 10)) - CGFloat(offset)
    }
    
    fileprivate func updateNewAngleValue(angle: Double){
        var newAngle = angle
        while newAngle > 360 {
            newAngle -= 360
        }
        
        self.newAngle = newAngle
    }
    
    fileprivate func searchWinnerSector() -> Int{
        let angleToSearch = 90.0
        let searched = angleToSearch - newAngle
        let target = searched < 0 ? searched + 360 : searched
        
        var output = 0
        
        for i in 0...angles.count - 1{
            
            //            print("searchied: \(target), current: \(i), [\(angles[i].minAngle) - \(angles[i].maxAngle)]")
            
            if(angles[i].minAngle < target && angles[i].maxAngle >= target){
                output = i
                //                print("searchied: found : \(i)")
                break
            }
        }
        
        return output
    }
}
