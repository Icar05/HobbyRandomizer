//
//  ViewDrawUtil.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 05.11.2021.
//

import UIKit

class ViewDrawUtil{
    
    
    fileprivate  var path = UIBezierPath()
    
    
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
