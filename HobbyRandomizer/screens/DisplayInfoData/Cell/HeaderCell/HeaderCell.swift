//
//  HeaderCell.swift
//  RS
//
//  Created by ICoon on 27.06.2022.
//

import UIKit

public final class HeaderCell: UILabel {
    
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 16.0
    @IBInspectable var rightInset: CGFloat = 16.0
    
    
    
    public var callback: (() -> Void )?
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    deinit {
        callback = nil
    }
    
    
    func configure(value: String){
        self.text = value
    }
    
    private func commonInit() {
        isUserInteractionEnabled = true
        
        self.backgroundColor = UIColor.colorMain
        self.textColor = UIColor.black
        self.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        self.frame = CGRect(
            x: 0,
            y: 0,
            width: self.frame.width,
            height: 46)
        
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        callback?()
    }
    
    public override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    public override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
    public override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
    
}
