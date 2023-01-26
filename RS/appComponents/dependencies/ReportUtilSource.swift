//
//  ReportUtilSource.swift
//  RS
//
//  Created by Галяткин Александр on 27.01.2023.
//

import Foundation

class ReportUtilSource: RandomReportUtilSource{
    
    
    var hash: [String : String]  = [
        "123": "Bingo!",
        "321": "Reversed"
    ]
    
    
    
    func getCategories() -> [RandomReportUtilModel] {
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
    
    func getConclusion(input: String) -> String {
        return hash[input] ?? "No conclusions"
    }
    
    
}
