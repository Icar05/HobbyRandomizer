//
//  InfoContentObject.swift
//  RS
//
//  Created by ICoon on 11.09.2022.
//

import Foundation

struct InfoContentItemObject: Codable{
    let name: String
    let models: [InfoModel]
}

struct InfoContentObject: Codable{
    let content: [InfoContentItemObject]
}
