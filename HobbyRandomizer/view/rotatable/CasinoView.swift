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
        
        self.prepareSectors()
       
        
        self.drawCircle(size: (outerCircleSize / 1.5) + 4, color: woodColor)
        self.drawCircle(size: (outerCircleSize / 1.5), color: green!)
        self.drawDividers(color: UIColor.brown)
        self.drawCircle(size: (outerCircleSize / 2), color: woodColor)
        self.drawCircle(size: (outerCircleSize / 2 - 4), color: UIColor.orange)
        self.drawCircle(size: (outerCircleSize / 5), color: woodColor)


        self.drawCenter()
        self.drawBall()
    }
    
    
    fileprivate func drawBall(){
        
        if(self.layerForRotation == nil){
            self.layerForRotation = CAShapeLayer()
                    
            let outherCirclePath = UIBezierPath(ovalIn:CGRect(x: 0, y: 0,  width: self.sizeOfView, height: self.sizeOfView))

            layerForRotation?.path = outherCirclePath.cgPath
            layerForRotation?.fillColor = UIColor.white.withAlphaComponent(0).cgColor
            
            let boulSize: CGFloat = 16
            let boulX: CGFloat = (self.sizeOfView / 2 ) - (boulSize / 2)
            let boulY: CGFloat = (self.sizeOfView  ) / 1.32
          
            let boulLayer = CAShapeLayer()
            let boulPath = UIBezierPath(ovalIn:CGRect(x: boulX, y: boulY,  width: boulSize, height: boulSize))
                boulLayer.path = boulPath.cgPath
                boulLayer.fillColor = UIColor.white.cgColor
                boulLayer.strokeColor = UIColor.black.cgColor
            
            
            self.layerForRotation?.bounds = self.layer.bounds
            self.layerForRotation?.position = CGPoint(x: sizeOfView / 2, y: sizeOfView / 2 )
            self.layerForRotation?.addSublayer(boulLayer)
            
            self.layer.addSublayer(layerForRotation!)
        }
       
    }
    
    override func searchAngle(index: Int) -> Double {
        
        let angleOfWantedSector = getAngles()[index].getMiddleAngle()
        let finalPosition = angleOfWantedSector + ( 360 * 2)
        let currentAngle = getStoredAngle() + 90
        
        return finalPosition - currentAngle
    }
    
    override func getLayerForRotation() -> CALayer {
        return self.layerForRotation!
    }
    
    fileprivate func drawDividers(color: UIColor){
        for i in 0...datasource.count - 1{
            
            let angle = getStartAngle(index: i)
            let radius: CGFloat = self.sizeOfView / 3.2
            let start = CGPoint(x: self.sizeOfView / 2, y: self.sizeOfView / 2)
            
            color.setFill()
            
            path.move(to: start)
            path.addArc(
                withCenter: start,
                radius: CGFloat(radius),
                startAngle: CGFloat(deg2rad(Double(angle - 1))),
                endAngle: CGFloat(deg2rad(Double(angle + 1))),
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
        let outerCircleSize =  self.sizeOfView - (2 * circlePadding)
        self.drawCircle(size: (outerCircleSize / 6), color: UIColor.brown)
        
        var startX = self.sizeOfView / 2
        var startY = self.sizeOfView / 3
        var endX = self.sizeOfView / 2
        var endY = (self.sizeOfView / 3 * 2)
        
        var start = CGPoint(x: startX, y: startY)
        var end = CGPoint(x: endX, y: endY)
        
        self.drawLineFromPointToPoint(start: start, end: end, lineWidth: 6, color: UIColor.brown)
        
        
         startX = self.sizeOfView / 3
         startY = self.sizeOfView / 2
         endX = (self.sizeOfView / 3 * 2)
         endY = self.sizeOfView / 2
        
         start = CGPoint(x: startX, y: startY)
         end = CGPoint(x: endX, y: endY)
        
        self.drawLineFromPointToPoint(start: start, end: end, lineWidth: 6, color: UIColor.brown)
        
        let sizeOfCircle = 16
        let topCirclePlace = CGPoint(x: Int(self.sizeOfView) / 2 - (sizeOfCircle / 2), y: Int(self.sizeOfView)/3 - ( sizeOfCircle / 2) )
        self.drawCircle(size: CGFloat(sizeOfCircle), color: UIColor.brown, point: topCirclePlace)
        
        
        let bottomCirclePlace = CGPoint(x: Int(self.sizeOfView) / 2 - (sizeOfCircle / 2), y: (Int(self.sizeOfView)/3 * 2) - ( sizeOfCircle / 2) )
        self.drawCircle(size: CGFloat(sizeOfCircle), color: UIColor.brown, point: bottomCirclePlace)
        
        let leftCirclePlace = CGPoint(x: Int(self.sizeOfView) / 3 - (sizeOfCircle / 2), y: Int(self.sizeOfView) / 2 - (sizeOfCircle / 2))
        self.drawCircle(size: CGFloat(sizeOfCircle), color: UIColor.brown, point: leftCirclePlace)
        
        let rightCirclePlace = CGPoint(x:( (Int(self.sizeOfView) / 3) * 2) - (sizeOfCircle / 2), y: Int(self.sizeOfView) / 2 - (sizeOfCircle / 2))
        self.drawCircle(size: CGFloat(sizeOfCircle), color: UIColor.brown, point: rightCirclePlace)
        
    }
    
    func drawLineFromPointToPoint(start: CGPoint, end: CGPoint, lineWidth: CGFloat, color: UIColor) {
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = lineWidth
        
        self.layer.addSublayer(shapeLayer)
        
    }
    
    override func childSetup(){}
    
    override func didFoundWinner(value: Int) {
        let model = RandomizerModel(index: datasource[value], color: getSectorColor(index: value))
        self.callback?(model)
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
