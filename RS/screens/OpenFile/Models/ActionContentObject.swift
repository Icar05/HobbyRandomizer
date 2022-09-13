//
//  ActionContentObject.swift
//  RS
//
//  Created by ICoon on 11.09.2022.
//

import Foundation



struct ActionContentItemObject: Codable{
    let name: String
    let models: [ActionModel]
}

struct ActionContentObject: Codable{
    let content: [ActionContentItemObject]
}
