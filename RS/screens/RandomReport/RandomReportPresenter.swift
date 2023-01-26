//
//  RandomReportPresenter.swift
//  RS
//
//  Created by Галяткин Александр on 26.01.2023.
//

import Foundation


public final class RandomReportPresenter {

    
    private let randomReportUtil: RandomReportUtil
            
    unowned var view: RandomReportViewController!
    
    
    
    public func set(view: RandomReportViewController) {
        self.view = view
    }
    
    init(randomReportUtil: RandomReportUtil){
        self.randomReportUtil = randomReportUtil
    }
    
  
}
