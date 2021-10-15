//
//  RandomizerUtil.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 13.10.2021.
//

import Foundation
import UIKit

@IBDesignable
class RandomizerUtil: UIView {
    
    
    fileprivate var count = 7
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var randomView: RandomizerView!
    
    @IBOutlet weak var selectorView: SelectorView!
        
    @IBOutlet weak var bang: BangButton!
    
    var delegate: ((_ value: Int) -> Void)? = nil
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareView()
    }
    
    
    
    func prepareView(){
        
        let bundle = Bundle(for: RandomizerUtil.self)
        bundle.loadNibNamed(String(describing: RandomizerUtil.self), owner: self, options: nil)
        addSubview(contentView)
        
        contentView.frame = self.bounds
        contentView.autoresizingMask =
            [UIView.AutoresizingMask.flexibleWidth,
             UIView.AutoresizingMask.flexibleHeight]


        randomView.callback = { (index, color) in
            self.selectorView.displayWinner(index: index + 1, color: color)
            self.delegate?(index)
        }
        randomView.setData(count: count)

        bang.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(bang(tapGestureRecognizer:)))
        bang.addGestureRecognizer(tapGesture)
        
        self.layer.masksToBounds = true
        
    }
    
    func setDataSource(count: Int){
        self.count = count
        self.randomView.setData(count: count)
    }
    
    @objc func bang(tapGestureRecognizer: UITapGestureRecognizer){
        self.randomView.rotate(itemsCount: self.count)
    }
   
    
}
