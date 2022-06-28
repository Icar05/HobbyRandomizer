//
//  RouleteView.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 13.10.2021.
//

import UIKit


protocol RoleteViewDelegate: NSObject{
    func onSectorDetected()
}

@IBDesignable
class RouleteView:  UIView {
    
    
    fileprivate var isPlaying = false
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var casinoView: CasinoView!
        
    @IBOutlet weak var bangBtn: BangButton!
    
    @IBOutlet weak var casinoSelectorView: CasinoSelectorView!
    
    weak var delegate: RoleteViewDelegate? = nil
    
    var targetIndex = -1
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareView()
    }
    
    
    fileprivate func prepareView(){
        
        let bundle = Bundle(for: RouleteView.self)
        bundle.loadNibNamed(String(describing: RouleteView.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask =
            [UIView.AutoresizingMask.flexibleWidth,
             UIView.AutoresizingMask.flexibleHeight]

        
        self.casinoView.callback = self
        
        self.bangBtn.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(bang(tapGestureRecognizer:)))
        self.bangBtn.addGestureRecognizer(tapGesture)
        self.bangBtn.text = Translations.Casino.play
        
        self.invalidateIntrinsicContentSize()

        self.layer.masksToBounds = true
    }
    
    @objc func bang(tapGestureRecognizer: UITapGestureRecognizer){
        if(isPlaying){
            return
        }
        
        if(self.targetIndex != -1){
            self.casinoView.rotate(index: targetIndex)
            self.clearTargetIndex()
            return
        }
        
        self.isPlaying = true
        self.casinoView.rotate()
    }
    
    func clearTargetIndex(){
        self.targetIndex = -1
    }
    
    func getDataSource() ->  [Int]{
        return self.casinoView.datasource
    }
    
}

extension RouleteView: RandomizerCallback{
    
    
    func onDetectSector() {
        self.delegate?.onSectorDetected()
    }
    
    func onWinnerFound(model: RandomizerModel) {
        self.casinoSelectorView.updateModel(model: model)
        self.isPlaying = false
    }
    
    func onAnimatonCanceled() {
        self.casinoSelectorView.clearSelection()
    }
}
