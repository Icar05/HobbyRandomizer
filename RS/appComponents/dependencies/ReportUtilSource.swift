//
//  ReportUtilSource.swift
//  RS
//
//  Created by Галяткин Александр on 27.01.2023.
//

import Foundation

class ReportUtilSource: RandomReportUtilSource{
    
    
   private var hash: [String : String]  = [
        "123": "Bingo!",
        "321": "Reversed"
    ]
    
    
    
    func getCategories() -> [RandomReportUtilModel] {
        return [
            RandomReportUtilModel(
                category: "Monday",
                values: [
                    "9:00",
                    "14:00",
                    "18:00",
                ]),
            RandomReportUtilModel(
                category: "Tuesday",
                values: [
                    "9:00",
                    "14:00",
                    "18:00",
                ]),
            RandomReportUtilModel(
                category: "Wednesday",
                values: [
                    "9:00",
                    "14:00",
                    "18:00",
                ])
            
        ]
    }
    
    func getConclusion(input: String) -> String {
        return hash[input] ?? "No conclusions"
    }
    
    
}
