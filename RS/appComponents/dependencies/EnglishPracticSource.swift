//
//  EnglishPracticSource.swift
//  RS
//
//  Created by Галяткин Александр on 02.02.2023.
//

import Foundation

public final class EnglishPracticSource: ReportSource{
    

    func getCategories() -> [RandomReportModel] {
        return [
//            RandomReportModel(
//                category: "Using coma:",
//                values: [
//                    "We need coma only after if, not before",
//                    "We need coma before and",
//                    "We don’t need coma before than",
//                    "Cause can connect 2 parts of sentence together without coma"
//                ]),
            RandomReportModel(
                category: "Present tense:",
                values: [
                    "Present Simple",
                    "Present Continious",
                    "Present Perfect",
                    "Present Perfect Contineous"
                ]),
            RandomReportModel(
                category: "Past tense:",
                values: [
                    "Past Simple",
                    "Past Continious",
                    "Past Perfect",
                    "Past Perfect Contineous"
                ]),
            RandomReportModel(
                category: "Future tense:",
                values: [
                    "Future Simple",
                    "Future Continious",
                    "Future Perfect",
                    "Future Perfect Contineous"
                ]),
            
            RandomReportModel(
                category: "Used to be",
                values: [
                    "I used to ...",
                    "I am used to ...",
                    "I get used to ..."
                ]),
            
            RandomReportModel(
                category: "Extra future rules",
                values: [
                    "...Made a sudden decision",
                    "...Going to do something",
                    "...Arrangement",
                    "...By Schedule"
                ]),
            
            RandomReportModel(
                category: "Gerund",
                values: [
                    "fancy ( Attitude ) ", "feel like ( Attitude ) ", "enjoy ( Attitude ) ", "(not) mind ( Attitude ) ",
                    "to dislike ( Attitude ) ",  "can’t stand ( Attitude ) ", "detest ( Attitude ) ",
                    "admit ( Opinion ) ",  "deny ( Opinion ) ", "consider ( Opinion ) ", "imagine ( Opinion ) ",
                       "recommend ( Opinion ) ",  "suggest ( Opinion ) ",
                      "commence ( Process ) ",  "keep ( Process ) ", "give up ( Process ) ", "finish ( Process ) ",
                      "miss ( Process ) ", "To take up ( Process ) ", "Dansing ( Sport or hobby ) ", "Reading ( Sport or hobby ) ", "to be (tired) of smth"
                      
                      
                ]),
        
            RandomReportModel(
                category: "Infinitive",
                values: [
                    "Afford","appear","ask","choose","expect","Decide",
                    "have","Hope","learn","Prepare","Promise","Plan",
                    "prove","Refuse","threaten", "wait", "want", "would like"
                ]),
            
            RandomReportModel(
                category: "Gerund & infinitive",
                values: [
                    "Begin","Continue","Hate","Intend","Love","Like","Start","Prefer","Advice","Permit"
                ]),
        ]
    }
    
    func getConclusion(input: String) -> String {
        "You have to use that:"
    }
    
    
}
