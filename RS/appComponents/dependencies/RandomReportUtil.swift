//
//  RandomReportUtil.swift
//  RS
//
//  Created by Галяткин Александр on 26.01.2023.
//

import Foundation

struct RandomReportModel{
    let category: String
    let values: [String]
}

struct RandomReportUtilResultModel{
    let code: String
    let conclusion: String
    let data: [RandomReportModel]
}

protocol ReportSource{
    func getCategories() -> [RandomReportModel]
    func getConclusion(input: String) -> String
}

public final class RandomReportUtil{
    
    private let source: ReportSource
    
    init(source: ReportSource){
        self.source = source
    }
        
    func prepareReport(delay: Double) -> RandomReportUtilResultModel{
        
        let rawData = self.source.getCategories()
        var code = ""
        let data: [RandomReportModel] = rawData.map{ item in
            
            let randomIndex = Int.random(in: 0..<item.values.count)
            code += "\(randomIndex + 1)"
            
            return RandomReportModel(
                category: item.category,
                values: [item.values[randomIndex]]
            )
        }
        
        let conclusion = self.source.getConclusion(input: code)
        
        return RandomReportUtilResultModel(
            code: code,
            conclusion: conclusion,
            data: data)
    }
    

}
