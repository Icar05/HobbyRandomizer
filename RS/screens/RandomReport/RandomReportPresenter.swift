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
        
        self.prepareData { result in
            self.view.showResultsState(data: result)
        }
    }
    
    
    private func prepareData(callback: @escaping (_ data: [ReportModel]) -> Void){
        let randomDelay = Double.random(in: 0..<10)
        DispatchQueue.main.asyncAfter(deadline: .now() + randomDelay) { [weak self] in
            print("delay: \(randomDelay)")
            callback(self?.getReportModels() ?? [])
        }
    }

    private func getReportModels() -> [ReportModel]{
        return [
            ReportHeaderCellModel(title: "Some Title"),
            KeyValueCellModel(key: "Key 1", value: "Value 1"),
            KeyValueCellModel(key: "Key 1", value: "Value 1"),
            KeyValueCellModel(key: "Key 1", value: "Value 1"),
            KeyValueCellModel(key: "Key 1", value: "Value 1"),
            KeyValueCellModel(key: "Key 1", value: "Value 1"),
            ResultCodeCellModel(code: "121332")
        ]
    }
  
}
