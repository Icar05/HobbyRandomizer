//
//  LabelWithCallback.swift
//  HobbyRandomizer
//
//  Created by ICoon on 09.06.2022.
//

import UIKit

public final class LabelWithCallBack: UILabel {
    
    
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
    
    private func commonInit() {
        isUserInteractionEnabled = true
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        callback?()
    }
    

    
}
