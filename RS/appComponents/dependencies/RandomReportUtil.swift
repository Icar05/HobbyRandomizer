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

public final class RandomReportUtil{
    
    
    func prepareReport(delay: Double) -> RandomReportUtilResultModel{
        
        let rawData = getRandomCategories()
        var code = ""
        let data: [RandomReportUtilModel] = rawData.map{ item in
            
            let randomIndex = Int.random(in: 0..<item.values.count)
            code += "\(randomIndex + 1)"
            
            return RandomReportUtilModel(
                category: item.category,
                values: [item.values[randomIndex]]
            )
        }
        
        return RandomReportUtilResultModel(
            code: code,
            conclusion: "Conclusions",
            data: data)
    }
    
    private func getRandomCategories() -> [RandomReportUtilModel]{
        return [
        
            RandomReportUtilModel(
                category: "category 1",
                values: [
                    "value 1",
                    "value 2",
                    "value 3",
                ]),
            RandomReportUtilModel(
                category: "category 2",
                values: [
                    "value 1",
                    "value 2",
                    "value 3",
                ]),
            RandomReportUtilModel(
                category: "category 3",
                values: [
                    "value 1",
                    "value 2",
                    "value 3",
                ])
        
        ]
    }
}
