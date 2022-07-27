//
//  CasinoView.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 13.10.2021.
//

import UIKit

@IBDesignable
class CasinoView: BaseRotatableView {
    
    
    fileprivate var layerForRotation: CAShapeLayer? = nil
    
    fileprivate var centerLayer: CAShapeLayer? = nil
    
    fileprivate let path = UIBezierPath()
    
    
    let datasource = [0, 32,15, 19,4, 21,2, 25, 17, 34, 6, 27, 13, 36, 11, 30,
                      8, 23, 10, 5, 24, 16, 33, 1, 20, 14, 31, 9, 22, 18, 29,
                      7, 28, 12, 35, 3, 26
    ]
    
    let woodColor = UIColor.brown
    
    let green = UIColor.coolGreen
    
    
    
    override func draw(_ rect: CGRect) {
        
        let outerCircleSize =  self.sizeOfView - (2 * circlePadding)
        self.drawCircle(size: outerCircleSize, color: woodColor)
        
        self.drawSectors()
        
        self.drawCircle(size: (outerCircleSize / 1.5) + 4, color: woodColor)
        self.drawCircle(size: (outerCircleSize / 1.5), color: green!)
        self.drawDividers(color: UIColor.brown)
        self.drawCircle(size: (outerCircleSize / 2), color: woodColor)
        self.drawCircle(size: (outerCircleSize / 2 - 4), color: UIColor.orange)
        self.drawCircle(size: (outerCircleSize / 5), color: woodColor)
        
        self.drawBall()
        self.drawCenter()
        self.backgroundColor = UIColor.clear
    }
    
    fileprivate func drawBall(){
        
        if(self.layerForRotation == nil){
            self.layerForRotation = self.viewDrawUtil.drawBall(sizeOfView: sizeOfView, bounds: self.layer.bounds)
            self.layer.addSublayer(layerForRotation!)
        }
    }
    
    override func childAnimationsCanceled() {
        self.centerLayer?.removeAllAnimations()
    }
    
    override func startChildAnimation() {
        let storedAngle: Double = 0
        let wantedAngle: Double = 90.0
        let rotateAnimation = prepareAnimation(startAngle: storedAngle, endAngle: wantedAngle)
        
        self.centerLayer?.add(rotateAnimation, forKey: nil)
    }
    
    override func searchAngle(index: Int) -> Double {
        return self.viewCalculateUtil.searchAngleForCasino(index: index)
    }
    
    override func getLayerForRotation() -> CALayer {
        return self.layerForRotation!
    }
    
    fileprivate func drawDividers(color: UIColor){
        for i in 0...datasource.count - 1{
            
            let angle = getStartAngle(index: i)
            let radius: CGFloat = self.sizeOfView / 3.2
            let start = CGPoint(x: self.sizeOfView / 2, y: self.sizeOfView / 2)
            let startAngle = CGFloat(viewCalculateUtil.deg2rad(Double(angle - 1)))
            let endAngle = CGFloat(viewCalculateUtil.deg2rad(Double(angle + 1)))
            
            color.setFill()
            
            path.move(to: start)
            path.addArc(
                withCenter: start,
                radius: CGFloat(radius),
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: true
            )
            
            path.close()
            path.fill()
        }
    }
    override func getColorForSection(sectionId: Int) -> UIColor {
        return getSectorColor(index: sectionId)
    }
    
    override func getAttributedString(fontSize: CGFloat, item: Int) -> NSAttributedString {
        return getTextString(fontSize: fontSize, text: "\(datasource[item])")
    }
    
    override func getItemsCount() -> Int {
        return self.datasource.count
    }
    
    func drawCenter(){
        
        if(centerLayer == nil){
            self.centerLayer = self.viewDrawUtil.drawRouleteCenter(
                sizeOfView: sizeOfView,
                circlePadding: circlePadding,
                bounds: self.layer.bounds)
            
            self.layer.addSublayer(centerLayer!)
        }
        
    }
    
    override func childSetup(){}
    
    override func didFoundWinner(value: Int) {
        let model = RandomizerModel(index: datasource[value], color: getSectorColor(index: value))
        self.callback?.onWinnerFound(model: model)
    }
    
    fileprivate func getSectorColor(index: Int) -> UIColor{
        if(index == 0){
            return green!
        }else if( index % 2 == 0){
            return UIColor.black
        }else{
            return UIColor.red
        }
    }
    
    fileprivate func getTextString(fontSize: CGFloat, text: String) ->  NSAttributedString{
        let dict:NSDictionary = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.strokeWidth: 5,
            NSAttributedString.Key.strokeColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "EuphemiaUCAS", size: fontSize)!
        ]
        return  NSAttributedString(string: text, attributes: dict as? [NSAttributedString.Key : Any])
    }
    
    
    
}
