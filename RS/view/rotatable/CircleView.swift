//
//  CircleView.swift
//  HobbyRandomizer
//
//  Created by ICoon on 23.06.2022.
//

@IBDesignable
class CircleView: BaseRotatableView {
    
    
    fileprivate var datasource = [UIColor]()
    
    
    fileprivate let colorsVariants = [UIColor.red, UIColor.orange]
    
    
    override  func childSetup() {
        self.datasource = prepareColors(max: 1)
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
            
            let index = i % 2 == 0 ? 0 : 1
            colors.a(contentsOf: colorsVariants[index])
        }
        return colors
    }
}



