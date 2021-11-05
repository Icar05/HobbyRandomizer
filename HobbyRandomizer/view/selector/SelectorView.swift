//
//  SelectorView.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 13.10.2021.
//

import Foundation
import UIKit

@IBDesignable
class SelectorView: UIView {
    
    
    fileprivate var viewDrawUtil = ViewDrawUtil()
    
    
    fileprivate var path = UIBezierPath()
    
    fileprivate var viewWidth: CGFloat = 300
    
    fileprivate var viewHeith: CGFloat = 400
    
    fileprivate var lineColor = UIColor.black
    
    fileprivate let padding = 20
    
    fileprivate let acsent = UIColor.brown
    
    fileprivate var textLayer = CATextLayer()
    
    fileprivate var circleLayer = CAShapeLayer()
        
    fileprivate var model: RandomizerModel? = nil
    
    
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
            self.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeith)
        }
    }
    
    
    func setup(){
        self.layer.bounds.size = CGSize(width: CGFloat(viewHeith), height: CGFloat(viewHeith))
        self.layer.masksToBounds = true
        self.backgroundColor = .white.withAlphaComponent(0)
    }
    
    
    
    override func draw(_ rect: CGRect) {
        var start = CGPoint(x: padding, y: Int(viewHeith) - padding)
        var end = CGPoint(x: Int(viewWidth) - padding, y: Int(viewHeith) - padding)
        self.drawLineFromPointToPoint(start: start, end: end, lineWidth: 10)
        
        start = CGPoint(x: padding, y: Int(viewHeith) - (padding + 15) )
        end = CGPoint(x: Int(viewWidth) - padding, y: Int(viewHeith) - (padding + 15))
        self.drawLineFromPointToPoint(start: start, end: end, lineWidth: 10)
        
        start = CGPoint(x: padding, y: Int(viewHeith) - padding + 10)
        end = CGPoint(x: padding, y: Int(viewHeith) - (padding + 50))
        self.drawLineFromPointToPoint(start: start, end: end, lineWidth: 10)
        
        start = CGPoint(x: Int(viewWidth) - padding, y: Int(viewHeith) - padding + 10)
        end = CGPoint(x: Int(viewWidth) - padding, y: Int(viewHeith) - (padding + 50))
        self.drawLineFromPointToPoint(start: start, end: end, lineWidth: 10)
        
        
        start = CGPoint(x: Int(viewWidth) / 2, y: 140)
        end = CGPoint(x: Int(viewWidth) / 3 - padding, y: Int(viewHeith) - (padding))
        self.drawLineFromPointToPoint(start: start, end: end, lineWidth: 10)
        
        let startOffset = 16
        
        start = CGPoint(x: Int(viewWidth) / 2 - startOffset, y: 140)
        end = CGPoint(x: Int(viewWidth) / 3 - padding - startOffset, y: Int(viewHeith) - (padding))
        self.drawLineFromPointToPoint(start: start, end: end, lineWidth: 10)
        
        start = CGPoint(x: Int(viewWidth) / 2, y: 140)
        end = CGPoint(x: ((Int(viewWidth) / 3) * 2) + padding , y: Int(viewHeith) - (padding))
        self.drawLineFromPointToPoint(start: start, end: end, lineWidth: 10)
        
        start = CGPoint(x: Int(viewWidth) / 2 + startOffset, y: 140)
        end = CGPoint(x: ((Int(viewWidth) / 3) * 2) + padding + startOffset , y: Int(viewHeith) - (padding))
        self.drawLineFromPointToPoint(start: start, end: end, lineWidth: 10)
        
        self.drawCircle(size: 60, color: .white)
        self.drawCircle(size: 50, color: acsent)
        
        if(model == nil){
            self.drawCircle(size: 50, color: .white, yOffset: Int(viewHeith) - 70)
            self.drawText(text: "?")
        }else{
            self.displayWinner(model: self.model!)
        }
        
        
    }
    
    fileprivate func getAttributedString(input: String) -> NSAttributedString{
        let dict:NSDictionary = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.strokeWidth: 5,
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: "EuphemiaUCAS", size: 25)!
        ]
       return NSAttributedString(string: input, attributes: dict as? [NSAttributedString.Key : Any])
    }
    
    func updateModel(model: RandomizerModel){
        self.model = model
        self.displayWinner(model: model)
    }
    
    func clearSelection(){
        self.model = nil
        self.drawCircle(size: 50, color: .white, yOffset: Int(viewHeith) - 70)
        self.drawText(text: "?")
    }
    
    fileprivate func displayWinner(model: RandomizerModel){
        self.drawCircle(size: 50, color: model.color, yOffset: Int(viewHeith) - 70)
        self.drawText(text: "\(model.index + 1)")
    }
    
    
    fileprivate func drawText(text: String){
        
        let startX = (viewWidth / 2) - 25
        let startY = Int(viewHeith) - 60
        
        textLayer.removeFromSuperlayer()
        textLayer = CATextLayer()
        textLayer.string = getAttributedString(input:text)
        textLayer.alignmentMode = .center
        textLayer.frame = CGRect(x: Int(startX), y: startY, width: 50, height: 40)
        
        layer.addSublayer(textLayer)
        
    }
    
    fileprivate func drawLineFromPointToPoint(start: CGPoint, end: CGPoint, lineWidth: CGFloat) {
        let shapeLayer = self.viewDrawUtil.drawLineFromPointToPoint(start: start, end: end, lineWidth: lineWidth, color: .black)
        self.layer.addSublayer(shapeLayer)
    }
    
    
    fileprivate func drawCircle(size: CGFloat, color: UIColor){
        let point = CGPoint(x: (viewWidth - size) / 2, y: (viewWidth - size) / 2)
        let circleLayer = self.viewDrawUtil.drawCircle(size: size, color: color, point: point)
        self.layer.addSublayer(circleLayer)
    }
    
    fileprivate func drawCircle(size: CGFloat, color: UIColor, yOffset: Int){
        circleLayer.removeFromSuperlayer()
        
        let point = CGPoint(x: (viewWidth - size) / 2, y: CGFloat(yOffset))
        self.circleLayer = self.viewDrawUtil.drawCircle(size: size, color: color, point: point, strokeColor: .black)
        layer.addSublayer(circleLayer)
    }
    
    
    
}



