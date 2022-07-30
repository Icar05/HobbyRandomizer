//
//  TimerDisplay.swift
//  RS
//
//  Created by ICoon on 30.07.2022.
//

import Foundation

protocol TimerDisplay: UIView{

    func setSingleUpdaterColor(value: Bool)
        
    func updateCurrentValue(current: Int, max: Int)
    
    func updateCircleColor(color: UIColor)
}

extension TimerDisplay {
    private func getColor(percent: Double) -> UIColor{
        if(percent < 33){
            return UIColor.coolGreen!
        }else if (percent < 66){
            return UIColor.coolOrange!
        }else{
            return UIColor.coolRed!
        }
    }
}
