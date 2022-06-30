//
//  YesNoUtil.swift
//  RS
//
//  Created by ICoon on 30.06.2022.
//

import Foundation
import UIKit

protocol YesNoUtilDelegate: NSObject{
    func onDetectSector()
    func onModelFound(randModel: RandomizerModel)
}

@IBDesignable
class YesNoUtil: UIView {

    
    fileprivate var count = 10
    
    fileprivate var isPlaying = false
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var randomView: YesNoRotatable!
    
    @IBOutlet weak var selectorView: SelectorView!
        
    @IBOutlet weak var bang: BangButton!
    
    weak var delegate: RandomizerUtilDelegate? = nil
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareView()
    }
    
    
    
    func prepareView(){
        
        let bundle = Bundle(for: YesNoUtil.self)
        bundle.loadNibNamed(String(describing: YesNoUtil.self), owner: self, options: nil)
        addSubview(contentView)
        
        contentView.frame = self.bounds
        contentView.autoresizingMask =
            [UIView.AutoresizingMask.flexibleWidth,
             UIView.AutoresizingMask.flexibleHeight]


        randomView.callback = self
        randomView.setData(count: count)

        bang.isUserInteractionEnabled = true
        bang.text = Translations.Random.play
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(bang(tapGestureRecognizer:)))
        bang.addGestureRecognizer(tapGesture)
        
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setPreferences(preferences: AppPrefferencesModel){
        self.randomView.setPreferences(preferences: preferences)
        self.selectorView.shouldShowYesNo(value: true)
    }
    
    func setBangButtonBackgroundColor(color: UIColor){
        self.bang.backgroundColor = color
    }
    
    @objc func bang(tapGestureRecognizer: UITapGestureRecognizer){
        if(!isPlaying){
            self.isPlaying = true
            self.randomView.rotate()
        }
        
    }
}

extension YesNoUtil: RandomizerCallback{
    
    
    func onDetectSector() {
        self.delegate?.onDetectSector()
    }
    
    func onWinnerFound(model: RandomizerModel) {
        self.selectorView.updateModel(model: model)
        self.delegate?.onModelFound(randModel: model)
        self.isPlaying = false
    }
    
    func onAnimatonCanceled() {
        self.selectorView.clearSelection()
    }
}
