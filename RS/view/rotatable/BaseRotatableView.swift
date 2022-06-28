//
//  BaseRotatableView.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 14.10.2021.
//

import UIKit
import AudioToolbox

protocol RandomizerCallback {
    func onWinnerFound(model: RandomizerModel) -> Void
    func onAnimatonCanceled() -> Void
    func onDetectSector() -> Void
}



struct RandomizerModel {
    let index: Int
    let color: UIColor
}

class BaseRotatableView: UIView {
    
    
    
    
    internal let viewDrawUtil = ViewDrawUtil()
    
    internal let viewCalculateUtil = ViewCalculateUtil()
    
    internal var sizeOfView: CGFloat = 300
    
    internal  let circlePadding: CGFloat = 10
    
    internal var callback: RandomizerCallback? = nil
        
    fileprivate var detectSectorUtil: DetectSectorUtil = DetectSectorUtil()
    
    fileprivate var baseAnimationObserver = BaseAnimationObserver()
    
    fileprivate var winnerIndex = 0
    
    fileprivate var wantedAngle: Double = 0
    
    fileprivate var animationDuration = 6.0
    
    
    
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
        self.translatesAutoresizingMaskIntoConstraints = false
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
        self.viewDrawUtil.drawCircle(size: size, color: color, sizeOfView: sizeOfView)
    }
    
    internal func drawCircle(size: CGFloat, color: UIColor, point: CGPoint){
        self.viewDrawUtil.drawCircleFromPoint(size: size, color: color, point: point)
    }
    
    internal func drawCircle(size: CGFloat, color: UIColor, point: CGPoint) -> CAShapeLayer{
        return self.viewDrawUtil.drawCircle(size: size, color: color, point: point)
      }
    
    internal func prepareSectors(){
        
        
        let minAngle = 0
        let maxAngle: Double = 360
        let itemsCount = getItemsCount()
        let sectorAngle: Double = maxAngle / Double(itemsCount)
        let fontSize = self.viewCalculateUtil.calculateFontSize(itemsCount: itemsCount)
        var startAngle: Double = Double(minAngle)
        var endAngle: Double = sectorAngle
        
        self.detectSectorUtil.setup(sectorSize: sectorAngle)
        
        
        for i in 0...itemsCount - 1{
            
            self.viewDrawUtil.drawSector(
                viewCalculateUtil.deg2rad(startAngle),
                viewCalculateUtil.deg2rad(endAngle),
                getColorForSection(sectionId: i),
                sizeOfView: sizeOfView,
                circlePadding: circlePadding)
            
            let angle = AngleOfSector(minAngle: startAngle, maxAngle: endAngle)
            self.viewCalculateUtil.appendAngle(angle: angle )
            
            let middleAngle: Double = (startAngle + endAngle) / 2
            let string = getAttributedString(fontSize: fontSize, item: i)
            
            let angleForText = viewCalculateUtil.deg2rad(middleAngle)
            self.viewDrawUtil.drawText(angle: angleForText, string: string, sizeOfView: sizeOfView, circlePadding: circlePadding)
            
            //increment next value
            startAngle += sectorAngle
            endAngle += sectorAngle
            
        }
    }
    
    internal func clearAngles(){
        self.viewCalculateUtil.clearAngles()
    }
    
    internal func rotate(index: Int){
        self.rotateWithAngle(index: index)
    }
    
    internal func rotate(){
        let randomIndex = Int.random(in: 0..<getItemsCount())
        self.rotateWithAngle(index: randomIndex)
    }
    
    internal func getStartAngle(index: Int) ->  Double{
        return self.viewCalculateUtil.getStartAngle(index: index)
    }
    
    internal func getLayerForRotation()-> CALayer{
        return self.layer
    }
    
    internal func searchAngle(index: Int) ->  Double{
        return self.viewCalculateUtil.searchAngle(index: index)
    }
    
    internal func startChildAnimation(){}
    
    internal func childAnimationsCanceled(){}
    
    internal func prepareAnimation(startAngle: Double, endAngle: Double) -> CABasicAnimation{
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.fromValue = Double(startAngle) * Double.pi / 180.0
            rotateAnimation.toValue = Double(startAngle + endAngle) * Double.pi / 180.0
            rotateAnimation.duration = animationDuration
            rotateAnimation.repeatCount = 0
            rotateAnimation.isRemovedOnCompletion = false
            rotateAnimation.fillMode = CAMediaTimingFillMode.forwards
            rotateAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        return rotateAnimation
    }
    /**
     PRIVATE ZONE
     */
    fileprivate func getSectorAngle() -> Double{
        let maxAngle: Double = 360
        return maxAngle / Double(getItemsCount())
    }
    
    fileprivate func rotateWithAngle(index: Int){
        let distance = self.viewCalculateUtil.searchDistanceToNearestSector()
        self.detectSectorUtil.distanceToNearesSector(leftToBorder: distance)
        self.wantedAngle =  self.searchAngle(index: index)
        self.winnerIndex = index
        self.animationDuration =  Double(((getItemsCount() / 8 ) * 2 ) + 2)
        
        let storedAngle = self.viewCalculateUtil.getStoredAngle()
        let animation = prepareAnimation(startAngle: storedAngle, endAngle: wantedAngle)
            animation.delegate = self
        self.getLayerForRotation().add(animation, forKey: nil)
        self.startChildAnimation()
    }
    
    fileprivate func onAnimationCanceled(){
        self.viewCalculateUtil.clearAngles()
        self.getLayerForRotation().removeAllAnimations()
        self.childAnimationsCanceled()
        self.callback?.onAnimatonCanceled()
    }
    
   
}

extension BaseRotatableView: DetectSectorUtilDelegate{
    func onDetectSector() {
        self.callback?.onDetectSector()
    }
}

extension BaseRotatableView: CAAnimationDelegate{
    
    func animationDidStart(_ anim: CAAnimation){
        let storedAngle = self.viewCalculateUtil.getStoredAngle()
        self.baseAnimationObserver.start(duration: animationDuration, oldAngle: storedAngle, newAngle: Double(wantedAngle))
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
        self.baseAnimationObserver.stop()
        self.didFoundWinner(value: winnerIndex)
        self.viewCalculateUtil.updateNewAngle(angle: wantedAngle)
        
        if(!flag){
            onAnimationCanceled()
        }
    }
}

extension BaseRotatableView: BaseAnimationObserverOnUpdate{
    func onUpdate(index: Double, currentAngle: Double, dirtyAngle: Double) {
        self.detectSectorUtil.update(currentAngle: dirtyAngle)
    }
}
