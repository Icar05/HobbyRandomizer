//
//  BaseRotatableView.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 14.10.2021.
//

import UIKit
import AudioToolbox

typealias RandomizerCallback = (_ model: RandomizerModel) -> Void

struct RandomizerModel {
    let index: Int
    let color: UIColor
}

struct AngleOfSector{
    let minAngle: Double
    let maxAngle: Double
}

extension AngleOfSector{
    func getMiddleAngle() -> Double{
        return  (minAngle + maxAngle) / 2
    }
}

class BaseRotatableView: UIView {
    
    
    
    fileprivate  var path = UIBezierPath()
    
    fileprivate var angles = [AngleOfSector]()
    
    fileprivate  var storedAngle: Double = 0
    
    internal var sizeOfView: CGFloat = 300
    
    internal  let circlePadding: CGFloat = 10
    
    internal var callback: RandomizerCallback? = nil
    
    fileprivate var animationDuration = 20.0
    
    fileprivate var detectSectorUtil: DetectSectorUtil = DetectSectorUtil()
    
    fileprivate var baseAnimationObserver = BaseAnimationObserver()
    
    fileprivate var winnerIndex = 0
    
    fileprivate var wantedAngle: Double = 0
    
    
    
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
        self.childSetup()
        self.detectSectorUtil.delegate = self
        self.baseAnimationObserver.delegate = self
    }
    
    
    
    /*
     INHERIT OVERRIDE ZONE
     */
    func childSetup(){}
    
    func didFoundWinner(value: Int){
        fatalError("Not implemented")
    }
    
    func getColorForSection(sectionId: Int) -> UIColor {
        fatalError("Not implemented")
    }
    
    func getAttributedString(fontSize: CGFloat, item: Int) -> NSAttributedString {
        fatalError("Not implemented")
    }
    
    func getItemsCount() -> Int{
        fatalError("Not implemented")
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
    
    internal func prepareSectors(){
        
        
        let minAngle = 0
        let maxAngle: Double = 360
        let itemsCount = getItemsCount()
        let sectorAngle: Double = maxAngle / Double(itemsCount)
        let fontSize = calculateFontSize(itemsCount: itemsCount)
        var startAngle: Double = Double(minAngle)
        var endAngle: Double = sectorAngle
        
        self.detectSectorUtil.setup(sectorSize: sectorAngle)
        
        
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
        self.storedAngle = 0
    }
    
    internal func rotate(index: Int){
        self.rotateWithAngle(index: index)
    }
    
    internal func rotate(){
        let randomIndex = Int.random(in: 0..<getItemsCount())
        self.rotateWithAngle(index: randomIndex)
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
    fileprivate func searchAngle(index: Int) ->  Double{
        
        let fullWinnerAngle = 810.0
        let currentMiddleAngle = self.angles[index].getMiddleAngle()
        let res =  fullWinnerAngle - currentMiddleAngle
        
        return res - storedAngle
    }
    
    fileprivate func getSectorAngle() -> Double{
        let maxAngle: Double = 360
        return maxAngle / Double(getItemsCount())
    }
    
    fileprivate func rotateWithAngle(index: Int){

        
        self.wantedAngle = searchAngle(index: index)
        self.winnerIndex = index
        self.detectSectorUtil.setNearestSector(nearestSector: searchNearestSector())
                        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.fromValue = Double(storedAngle) * Double.pi / 180.0
            rotateAnimation.toValue = Double(storedAngle + wantedAngle) * Double.pi / 180.0
            rotateAnimation.duration = animationDuration
            rotateAnimation.repeatCount = 0
            rotateAnimation.isRemovedOnCompletion = false
            rotateAnimation.delegate = self
            rotateAnimation.fillMode = CAMediaTimingFillMode.forwards
            rotateAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    fileprivate func searchNearestSector() -> Double{
        return  angles.first { angle in angle.minAngle > storedAngle}!.minAngle
    }
    
    fileprivate func updateNewAngle(angle: Double){
        self.storedAngle += angle
        
        if(self.storedAngle > 360){
            while storedAngle > 360 {
                self.storedAngle -= 360
            }
        }
    }
    
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
}

extension BaseRotatableView: DetectSectorUtilDelegate{
    func onDetectSector() {
//        print("sector found: !")
//        AudioServicesPlaySystemSoundWithCompletion(SystemSoundID(SoundsForTest.testing), nil)
    }
}

struct SoundsForTest{
    static let picker = 1148
    static let testing = 1050
    static let nice = 1057
}


extension BaseRotatableView: CAAnimationDelegate{
    
    func animationDidStart(_ anim: CAAnimation){
        self.baseAnimationObserver.start(duration: animationDuration, oldAngle: storedAngle, newAngle: Double(wantedAngle))
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
        self.baseAnimationObserver.stop()
        self.didFoundWinner(value: winnerIndex)
        self.updateNewAngle(angle: wantedAngle)
    }
}

extension BaseRotatableView: BaseAnimationObserverOnUpdate{
    func onUpdate(index: Double, currentAngle: Double) {
        print(" \(index) -> [\(storedAngle) > \(currentAngle) < \(wantedAngle)]")
//        self.detectSectorUtil.update(currentAngle: angleCurrent)
    }
}
