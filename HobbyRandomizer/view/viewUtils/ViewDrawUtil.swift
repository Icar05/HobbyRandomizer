//
//  ViewDrawUtil.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 05.11.2021.
//

import UIKit

class ViewDrawUtil{
    
    
    fileprivate  var path = UIBezierPath()
    
    
    func drawRouleteCenter(sizeOfView: CGFloat, circlePadding: CGFloat, bounds: CGRect) -> CAShapeLayer{
        
        let centerLayer = CAShapeLayer()
        
        let horizontalLineLayer = drawLineFromPointToPoint(
            start: CGPoint(x: sizeOfView / 2, y: sizeOfView / 3),
            end: CGPoint(x: sizeOfView / 2, y: ( sizeOfView / 3 * 2)),
            lineWidth: 6, color: UIColor.brown)
        
        centerLayer.addSublayer(horizontalLineLayer)
        
        let verticalLayer = drawLineFromPointToPoint(
            start: CGPoint(x: sizeOfView / 3, y: sizeOfView / 2),
            end: CGPoint(x: (sizeOfView / 3 * 2), y: sizeOfView / 2),
            lineWidth: 6, color: UIColor.brown)
        
        centerLayer.addSublayer(verticalLayer)
        
        
        let outerCircleSize =  sizeOfView - (2 * circlePadding)
        drawCircle(size: (outerCircleSize / 6), color: UIColor.brown, sizeOfView: sizeOfView)
        
        let sizeOfCircle: CGFloat = 16
        
        let topCirclePlace = CGPoint(
            x: (sizeOfView / 2) - ( sizeOfCircle / 2) ,
            y: (sizeOfView / 3) - ( sizeOfCircle / 2))
        let topCircle: CAShapeLayer = drawCircle(size: sizeOfCircle, color: UIColor.brown, point: topCirclePlace)
        
        centerLayer.addSublayer(topCircle)
        
        
        let bottomCirclePlace = CGPoint(
            x: (sizeOfView) / 2 - (sizeOfCircle / 2),
            y: ((sizeOfView)/3 * 2) - ( sizeOfCircle / 2) )
        let bottomCirle: CAShapeLayer = drawCircle(size: CGFloat(sizeOfCircle), color: UIColor.brown, point: bottomCirclePlace)
        
        centerLayer.addSublayer(bottomCirle)
        
        let leftCirclePlace = CGPoint(
            x: (sizeOfView) / 3 - (sizeOfCircle / 2),
            y: (sizeOfView) / 2 - (sizeOfCircle / 2))
        let leftCircle: CAShapeLayer = drawCircle(size: CGFloat(sizeOfCircle), color: UIColor.brown, point: leftCirclePlace)
        
        centerLayer.addSublayer(leftCircle)
        
        let rightCirclePlace = CGPoint(
            x:  ((sizeOfView)/3 * 2) - ( sizeOfCircle / 2),
            y:  (sizeOfView) / 2 - (sizeOfCircle / 2))
        let rightCircle: CAShapeLayer = drawCircle(size: CGFloat(sizeOfCircle), color: UIColor.brown, point: rightCirclePlace)
        
        centerLayer.addSublayer(rightCircle)
        
        centerLayer.bounds = bounds
        centerLayer.position = CGPoint(x: sizeOfView / 2, y: sizeOfView / 2 )
        
        return centerLayer
    }
    
    func drawBall(sizeOfView: CGFloat, bounds: CGRect) -> CAShapeLayer {
        let layerForRotation = CAShapeLayer()
        
        let outherCirclePath = UIBezierPath(ovalIn:CGRect(x: 0, y: 0,  width: sizeOfView, height: sizeOfView))
        
        layerForRotation.path = outherCirclePath.cgPath
        layerForRotation.fillColor = UIColor.white.withAlphaComponent(0).cgColor
        
        let boulSize: CGFloat = 16
        let boulX: CGFloat = (sizeOfView / 2 ) - (boulSize / 2)
        let boulY: CGFloat = (sizeOfView) / 1.32
        
        let boulLayer = CAShapeLayer()
        let boulPath = UIBezierPath(ovalIn:CGRect(x: boulX, y: boulY,  width: boulSize, height: boulSize))
        boulLayer.path = boulPath.cgPath
        boulLayer.fillColor = UIColor.white.cgColor
        boulLayer.strokeColor = UIColor.black.cgColor
        
        
        layerForRotation.bounds = bounds
        layerForRotation.position = CGPoint(x: sizeOfView / 2, y: sizeOfView / 2 )
        layerForRotation.addSublayer(boulLayer)
        return layerForRotation
    }
    
    func drawLineFromPointToPoint(start: CGPoint, end: CGPoint, lineWidth: CGFloat, color: UIColor) -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = lineWidth
        
        return shapeLayer
        
    }
    
    func drawCircle(size: CGFloat, color: UIColor, point: CGPoint) -> CAShapeLayer{
        let layer = CAShapeLayer()
        let path = UIBezierPath(ovalIn:CGRect(x: point.x, y: point.y, width: size, height: size))
        layer.path = path.cgPath
        layer.fillColor = color.cgColor
        
        return layer
    }
    
    func drawCircleFromPoint(size: CGFloat, color: UIColor, point: CGPoint) -> Void{
        color.setFill()
        self.path = UIBezierPath(ovalIn:CGRect(x: point.x, y: point.y, width: size, height: size))
        self.path.fill()
    }
    
    func drawCircle(size: CGFloat, color: UIColor, sizeOfView: CGFloat) -> Void{
        color.setFill()
        let point = (sizeOfView - size) / 2
        self.path = UIBezierPath(ovalIn:CGRect(x: point, y: point, width: size, height: size))
        self.path.fill()
    }
    
    func drawText(angle: CGFloat, string: NSAttributedString, sizeOfView: CGFloat, circlePadding: CGFloat){
        let centerPoint = CGPoint(x: sizeOfView / 2, y: sizeOfView / 2)
        let textSize: CGSize = string.size()
        let radius: CGFloat = (sizeOfView / 2 ) - textSize.width - (circlePadding * 2)
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        let t: CGAffineTransform = CGAffineTransform(translationX: centerPoint.x, y: centerPoint.y)
        
        let r: CGAffineTransform = CGAffineTransform(rotationAngle: angle)
        context.concatenate(t)
        context.concatenate(r)
        
        let newPoint = CGPoint(x: radius-textSize.width/2, y: -textSize.height/2)
        string.draw(at: newPoint)
        
        context.concatenate(r.inverted())
        context.concatenate(t.inverted())
    }
    
    func drawSector(_ startAngle: CGFloat, _ endAngle: CGFloat, _ color: UIColor, sizeOfView: CGFloat, circlePadding: CGFloat){
        
        let center = sizeOfView / 2
        let viewCenter = CGPoint(x: sizeOfView / 2, y: sizeOfView / 2)
        let radius = center - (circlePadding * 2) //height of sector
        
        color.setFill()
        
        self.path = UIBezierPath()
        self.path.move(to: viewCenter)
        self.path.addArc(
            withCenter: viewCenter,
            radius: CGFloat(radius),
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )
        
        self.path.close()
        self.path.fill()
    }
    
}
