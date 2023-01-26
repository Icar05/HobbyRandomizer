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
    
    func viewDidLoad(){
        self.view.showInitialState()
    }
    
    
    func prepareReport(){
        
        self.view.showLoadingState()
        
        self.prepareData {
            self.view.showResultsState()
        }
    }
    
    
    private func prepareData(callback: @escaping () -> Void){
        let randomDelay = Double.random(in: 0..<20)
        DispatchQueue.main.asyncAfter(deadline: .now() + randomDelay) {
            print("delay: \(randomDelay)")
            callback()
        }
    }

  
}
