//
//  RandomizerView.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 12.10.2021.
//

import Foundation
import UIKit




@IBDesignable
class RandomizerView: BaseRotatableView {
    
    
    fileprivate var datasource = [UIColor]()
    
    
    fileprivate let colorsRainbow = [UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.blue, UIColor.systemIndigo, UIColor.purple]
    
    
    override  func childSetup() {
        self.datasource = prepareColors(max: 1)
    }
    
    
    override func draw(_ rect: CGRect) {
        let outerCircleSize =  self.sizeOfView - (2 * circlePadding)
        self.drawCircle(size: outerCircleSize, color: UIColor.black)
        
        self.prepareSectors(itemsCount: datasource.count)
        
        self.drawCircle(size: self.sizeOfView / 4, color: .black)
        self.drawCircle(size: self.sizeOfView / 5, color: .white)
    }
    
    
    override func getColorForSection(sectionId: Int) -> UIColor {
        return self.datasource[sectionId]
    }
    
    override func getAttributedString(fontSize: CGFloat, item: Int) -> NSAttributedString {
        return getTextString(fontSize: fontSize, text: "\(item + 1)")
    }
    
    override func didFoundWinner(value: Int) {
        self.callback?(value, datasource[value])
    }

    
    func setData(count: Int){
        if(count < 1){
            return
        }
        
        
        self.clearAngles()
        self.datasource = [UIColor]()
        self.datasource = prepareColors(max: count)
        self.setNeedsDisplay()
    }
    
    
    fileprivate func getTextString(fontSize: CGFloat, text: String) ->  NSAttributedString{
        let dict:NSDictionary = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.strokeWidth: 5,
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: "EuphemiaUCAS", size: fontSize)!
        ]
        return  NSAttributedString(string: text, attributes: dict as? [NSAttributedString.Key : Any])
    }
    

    
    fileprivate func prepareColors(max: Int)-> [UIColor]{
        
        let dataSourceCount = max > 100 ? 100 : max
        
        var counter = 0
        var colors: [UIColor] = [UIColor]()
        for i in 0...dataSourceCount - 1{
            
            if(i % 7 == 0 && i + 1 == dataSourceCount){
                colors.append(UIColor.systemPink)
            }else{
                if(counter > 6){
                    counter = 0
                }
                
                let color = colorsRainbow[counter]
                colors.append(color)
                counter += 1
            }
            
            
        }
        return colors
    }
}



