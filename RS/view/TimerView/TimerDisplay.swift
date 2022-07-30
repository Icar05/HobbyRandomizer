//
//  TimerDisplay.swift
//  RS
//
//  Created by ICoon on 30.07.2022.
//

import Foundation

protocol TimerDisplay: UIView{

    func setSingleUpdaterColor(value: Bool)
    
    func setMaxTimeInSeconds(maxTimeInSeconds: Int)
    
    func updateCurrentValue(current: Int, max: Int)
    
    func updateInnerColor(color: UIColor)
    
    func updateOutColor(color: UIColor)
}
