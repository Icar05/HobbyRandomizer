//
//  VerticalScrollView.swift
//  RS
//
//  Created by ICoon on 29.06.2022.
//

import Foundation

class VerticalScrollView : UIScrollView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {}

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        setVerticalInParent()
        return contentSize
    }
    
    private func setVerticalInParent(){
        guard let parent = superview , self.contentSize.height > 0 else {
            return
        }
        
   
        let parentInsets = parent.safeAreaInsets.top + parent.safeAreaInsets.bottom
        let parentHeight = parent.bounds.height - parentInsets
        let contentSize = self.contentSize.height
        
        if(parentHeight > contentSize){
            let newTopInset = ((parentHeight - contentSize) / 2)
            self.contentInset.top = newTopInset
        }
    }
}

