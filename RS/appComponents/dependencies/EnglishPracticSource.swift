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
            
//            RandomReportModel(
//                category: "Gerund & infinitive",
//                values: [
//                    "Begin","Continue","Hate","Intend","Love","Like","Start","Prefer","Advice","Permit"
//                ]),
            
            RandomReportModel(
                category: "Сonditions",
                values: [
                    "0 Condition",
                    "1 Condition",
                    "2 Condition",
                    "3 Condition",
                ]),
            RandomReportModel(
                category: "Would rather ( Desigion )",
                values: [
                    "Simple",
                    "Past",
                    "Negative",
                ]),
            
            RandomReportModel(
                category: "Had better (Advice)",
                values: [
                    "Simple",
                    "Past",
                    "Negative",
                ]),
            
            RandomReportModel(
                category: "Wish ( if only )",
                values: [
                    "Regret in present",
                    "Hope on future",
                    "Complaining",
                    "Regret about possibilities",
                    "Regret in past",
                ]),
            
            RandomReportModel(
                category: "Modal verb",
                values: [
                    "Should ( Advice )", "Must ( from inside )", "Have ( from outide )", "May (permission)", "Might (possibility)", "Could (ability)"
                ]),
            
            RandomReportModel(
                category: "Modal verb past",
                values: [
                    "Should in past", "Should in past negative",
                    "Would in past", "Would in past negative",
                    "Could in past", "Could in past negative",
                ]),
            
            RandomReportModel(
                category: "Indirect question",
                values: [
                    "Answer Yes/No",
                    "Particular answer"
                ]),
            
            RandomReportModel(
                category: "Tags question",
                values: [
                    "Simple tag question",
                    "I am",
                    "Let's",
                    "Order",
                    "Enyone"
                ]),
            
            RandomReportModel(
                category: "Quantifiers",
                values: [
                    "Many", "Much", "Just Few", "Just Little", "A lot of", "lake of countable", "lake of uncountable"
                ]),
            
            RandomReportModel(
                category: "Comparsion",
                values: [
                    "As ... As",
                    "the more ..., the more"
                ]),
            
            RandomReportModel(
                category: "Extra rules",
                values: [
                    "Opposite prefix",
                    "Adjective & Adverb",
                    "But / though",
                    "Unless = if not",
                    "Weather = if yes or not together",
                    "In spite of",
                    "Despite the smth",
                    "Although",
                    "Then / Than",
                    "Tell vs say",
                    "Let",
                    "Suggestions / Consider",
                    "Next period",
                    "- Start from time, start with something…"
                ]),
            
            
            RandomReportModel(
                category: "Extra patterns",
                values: [
                    "Likewise / Otherwise",
                    "Nonetheless",
                    "Moreover, Futhermore",
                    "much more",
                    "Likely ( most likely -Be likely)",
                    "In most cases",
                    "Nessesarely",
                    "Although",
                    "The best way of…",
                    "Searching for",
                    "That much = enought time",
                    "Unless = if not",
                    "With = if only",
                    "Though ( «but» in the end of sentence )",
                    "Whatever = ( if yes and not together, in any way )",
                    "In order to ( for something)",
                    "Lest ( in order not to)",
                    "vice versa, to the contrary, backwards ",
                    "Up to down",
                    "Feel free",
                    "Hand on a minute",
                    "Once",
                    "Be able",
                    "How come?",
                    "To succeed in",
                    "to have smth done..."
                ]),
            
        ]
    }
    
    func getConclusion(input: String) -> String {
        "You have to use that:"
    }
    
    
}
