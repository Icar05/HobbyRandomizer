//
//  RouleteView.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 13.10.2021.
//

import UIKit

@IBDesignable
class RouleteView:  UIView {
    
    
    
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var casinoView: CasinoView!
        
    @IBOutlet weak var bangBtn: BangButton!
    
    @IBOutlet weak var casinoSelectorView: CasinoSelectorView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareView()
    }
    
    
    func prepareView(){
        
        let bundle = Bundle(for: RouleteView.self)
        bundle.loadNibNamed(String(describing: RouleteView.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask =
            [UIView.AutoresizingMask.flexibleWidth,
             UIView.AutoresizingMask.flexibleHeight]

        
        self.casinoView.callback = {(index, color) in
            self.casinoSelectorView.displayWinner(index: index, color: color)
        }
        
        self.bangBtn.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(bang(tapGestureRecognizer:)))
        self.bangBtn.addGestureRecognizer(tapGesture)
        

        self.layer.masksToBounds = true
    }
    
    @objc func bang(tapGestureRecognizer: UITapGestureRecognizer){
        self.casinoView.rotate()
    }
    
}
