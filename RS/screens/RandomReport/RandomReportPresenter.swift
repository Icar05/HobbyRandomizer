//
//  RandomReportPresenter.swift
//  RS
//
//  Created by Галяткин Александр on 26.01.2023.
//

import Foundation


public final class RandomReportPresenter {

    
    private let maxDelay: Double = 7
    
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
        let randomDelay = Double.random(in: 0..<maxDelay)
        DispatchQueue.main.asyncAfter(deadline: .now() + randomDelay) { [weak self] in
            callback(self?.getReportModels(delay: randomDelay) ?? [])
        }
    }

    private func getReportModels(delay: Double) -> [ReportModel]{
        let results = self.randomReportUtil.prepareReport(delay: delay)
        
        let shortDelay = Double(round(100 * delay) / 100)
        let code = "#\(results.code) - \(shortDelay)"
        var models: [ReportModel] = [ReportEmptyCellModel()]
        
        models.append(ReportHeaderCellModel(title: results.conclusion))
        results.data.forEach{
            models.append(KeyValueCellModel(key: $0.category, value: $0.values.first ?? ""))
        }
        
        models.append(ResultCodeCellModel(code: code))
        models.append(ReloadReportCellModel(callback: { [weak self ] in
            self?.view.playClick()
            self?.view.showInitialState()
        }))
        
        return models
    }
  
}
