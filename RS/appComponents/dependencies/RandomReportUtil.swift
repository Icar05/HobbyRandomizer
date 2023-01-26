//
//  RandomReportUtil.swift
//  RS
//
//  Created by Галяткин Александр on 26.01.2023.
//

import Foundation

struct RandomReportUtilModel{
    let category: String
    let values: [String]
}

struct RandomReportUtilResultModel{
    let code: String
    let conclusion: String
    let data: [RandomReportUtilModel]
}

protocol RandomReportUtilSource{
    func getCategories() -> [RandomReportUtilModel]
    func getConclusion(input: String) -> String
}

public final class RandomReportUtil{
    
    private let source: RandomReportUtilSource
    
    init(source: RandomReportUtilSource){
        self.source = source
    }
        
    func prepareReport(delay: Double) -> RandomReportUtilResultModel{
        
        let rawData = self.source.getCategories()
        var code = ""
        let data: [RandomReportUtilModel] = rawData.map{ item in
            
            let randomIndex = Int.random(in: 0..<item.values.count)
            code += "\(randomIndex + 1)"
            
            return RandomReportUtilModel(
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
