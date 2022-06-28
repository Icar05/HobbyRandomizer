//
//  VerticalCollectionView.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import Foundation

class VerticalCollectionView: UICollectionView {
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        isScrollEnabled = false
    }

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }

    override var intrinsicContentSize: CGSize {
        setVerticalInParent()
        return contentSize
    }
    
    private func setVerticalInParent(){
        guard let parent = superview else {
            return
        }
        
        let topOffset = 50.0
        let parentInsets = parent.safeAreaInsets.top + parent.safeAreaInsets.bottom
        let parentHeight = parent.bounds.height - parentInsets - topOffset
        let contentSize = self.contentSize.height
        
        if(parentHeight > contentSize){
            let newTopInset = ((parentHeight - contentSize) / 2)
            self.contentInset.top = newTopInset
        }
    }
}
