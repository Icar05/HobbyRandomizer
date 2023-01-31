//
//  ReportUtilSource.swift
//  RS
//
//  Created by Галяткин Александр on 27.01.2023.
//

import Foundation

class ReportUtilSource: RandomReportUtilSource{
    
    
    private var hash: [String : String]  = [ :
//        "123": "Bingo!",
//        "321": "Reversed"
    ]
    
    
    
    func getCategories() -> [RandomReportUtilModel] {
        return [
            RandomReportUtilModel(
                category: "Year",
                values: getYearValues()),
            RandomReportUtilModel(
                category: "Month",
                values: getMonthValues()),
            RandomReportUtilModel(
                category: "Day",
                values: getDayValues()),
            RandomReportUtilModel(
                category: "Time",
                values: getTimeValues())
        ]
    }
    
    func getConclusion(input: String) -> String {
        return hash[input] ?? "No conclusions"
    }
    
    
    private func getDayValues() -> [String]{
        return (1...28).compactMap{String($0)}
    }
    
    private func getMonthValues() -> [String]{
        return DateFormatter().monthSymbols
    }
    
    private func getYearValues() -> [String]{
        return (1946...Calendar.current.component(.year, from: Date())).compactMap{String($0)}
    }
    
    private func getTimeValues() -> [String]{
        return (1...24)
            .compactMap{String($0)}
            .compactMap{ "\($0):\(String(format: "%02d", Int.random(in: 1..<61)))"
        }
    }
    
    
}
