//
//  PlayContentObject.swift
//  RS
//
//  Created by ICoon on 11.09.2022.
//

import Foundation

struct PlayContentItemObject: Codable{
    let name: String
    let models: [String]
}

struct PlayContentObject: Codable{
    let content: [PlayContentItemObject]
}
