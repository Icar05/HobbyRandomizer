//
//  UtilView.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 13.10.2021.
//

import Foundation
import UIKit

@IBDesignable
class UtilView : UIView {
    
    fileprivate var count = 7
    
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var start: UIButton!
    
    @IBOutlet weak var randomizer: RandomizerView!
    
    @IBOutlet weak var selectorView: SelectorView!
    
    @IBOutlet weak var countLabel: UILabel!
    
    
    @IBAction func inCreaseClick(_ sender: UIButton) {
        if(count < 100){
            count += 1
            self.countLabel.text = "\(count)"
            self.randomizer.setData(count: count)
        }
    }
    
    @IBAction func decreaseClick(_ sender: UIButton) {
        if(count > 1){
            count -= 1
            self.countLabel.text = "\(count)"
            self.randomizer.setData(count: count)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareView()
    }
    
    
    
    func prepareView(){
        
        let bundle = Bundle(for: UtilView.self)
        bundle.loadNibNamed(String(describing: UtilView.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask =
            [UIView.AutoresizingMask.flexibleWidth,
             UIView.AutoresizingMask.flexibleHeight]
        
        
        randomizer.callback = { (index, color) in
            self.selectorView.displayWinner(index: index + 1, color: color)
        }
        randomizer.setData(count: count)
        
        self.countLabel.text = "\(count)"
        start.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.layer.masksToBounds = true
        
    }
    
    
    @objc func buttonAction(sender: UIButton!){
        randomizer.rotate()
    }
    
   
    
}
