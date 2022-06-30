//
//  YesNoRotatable.swift
//  RS
//
//  Created by ICoon on 30.06.2022.
//

import Foundation


@IBDesignable
class YesNoRotatable: BaseRotatableView {
    
    
    
    fileprivate var datasource = [UIColor]()
    
    fileprivate var acceptedColors = [UIColor.red, UIColor.orange]
        
    fileprivate var count = 10
    
    
    
    
    func setPreferences(preferences: AppPrefferencesModel){
        self.acceptedColors = [preferences.yesColor.uiColor, preferences.noColor.uiColor]
        self.count = Int(preferences.yesNoCount)
        self.setNeedsDisplay()
    }
    
    override  func childSetup() {
        self.datasource = prepareColors()
    }
    
    
    override func draw(_ rect: CGRect) {
        let outerCircleSize =  self.sizeOfView - (2 * circlePadding)
        self.drawCircle(size: outerCircleSize, color: UIColor.black)
        
        self.prepareSectors()
        
        self.drawCircle(size: self.sizeOfView / 4, color: .black)
        self.drawCircle(size: self.sizeOfView / 5, color: .white)
    }
    
    override func getItemsCount() -> Int {
        return self.datasource.count
    }
    
    override func getColorForSection(sectionId: Int) -> UIColor {
        return self.datasource[sectionId]
    }
    
    override func getAttributedString(fontSize: CGFloat, item: Int) -> NSAttributedString {
        return getTextString(fontSize: fontSize, text: "\(item + 1)")
    }
    
    override func didFoundWinner(value: Int) {
        let model = RandomizerModel(index: value, color: datasource[value])
        self.callback?.onWinnerFound(model: model)
    }

    
    func setData(count: Int){
        if(count < 1){
            return
        }
        
        
        self.clearAngles()
        self.datasource = [UIColor]()
        self.datasource = prepareColors()
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
    

    
    fileprivate func prepareColors()-> [UIColor]{
        var colors: [UIColor] = [UIColor]()
        
        for i in 0...count - 1{
            let index = i % 2 == 0 ? 1: 0
            colors.append(acceptedColors[index])
            
        }
        return colors
    }
}



