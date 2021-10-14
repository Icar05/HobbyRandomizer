//
//  PrettyButton.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 13.10.2021.
//

import UIKit

class PrettyLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 7.0
    @IBInspectable var rightInset: CGFloat = 7.0
    @IBInspectable var labelText: String  = "" {
        didSet{
            self.text = labelText
        }
    }
    
    
    

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        self.text = labelText
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
    override var bounds: CGRect {
        didSet {
            // ensures this works within stack views if multi-line
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
            
            layer.borderColor = UIColor.gray.cgColor
            layer.borderWidth = 0.15
            layer.cornerRadius = 10
            
            textColor = UIColor.lightGray
            textAlignment = .center
            font = UIFont(name: "System-Thin", size: 15.0)
        }
    }
}

