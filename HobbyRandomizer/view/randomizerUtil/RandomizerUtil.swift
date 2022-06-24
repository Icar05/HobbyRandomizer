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
    
    fileprivate var isPlaying = false
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var randomView: RandomizerView!
    
    @IBOutlet weak var selectorView: SelectorView!
        
    @IBOutlet weak var bang: BangButton!
    
    var delegate: ((_ model: RandomizerModel) -> Void)? = nil
    
    
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


        randomView.callback = self
        randomView.setData(count: count)

        bang.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(bang(tapGestureRecognizer:)))
        bang.addGestureRecognizer(tapGesture)
        
        self.layer.masksToBounds = true
        
    }
    
    func setBangButtonBackgroundColor(color: UIColor){
        self.bang.backgroundColor = color
    }
    
    func setDataSource(count: Int){
        if(!isPlaying){
            self.count = count
            self.randomView.setData(count: count)
        }
    }
    
    @objc func bang(tapGestureRecognizer: UITapGestureRecognizer){
        if(!isPlaying){
            self.isPlaying = true
            self.randomView.rotate()
        }
        
    }
}

extension RandomizerUtil: RandomizerCallback{
    func onWinnerFound(model: RandomizerModel) {
        self.selectorView.updateModel(model: model)
        self.delegate?(model)
        self.isPlaying = false
    }
    
    func onAnimatonCanceled() {
        self.selectorView.clearSelection()
    }
}
