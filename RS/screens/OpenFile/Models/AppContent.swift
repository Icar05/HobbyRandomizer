//
//  AppContent.swift
//  RS
//
//  Created by ICoon on 11.09.2022.
//

import Foundation

struct AppContent: Codable{
    let info: InfoContentObject
    let action: ActionContentObject
    let play: PlayContentObject
}

extension AppContent{
    static func getMock() -> AppContent{
       return AppContent(
            info: InfoContentObject(
                content: [
                    InfoContentItemObject(
                    name: "info1",
                    models: [
                        InfoModel(
                            title: "Title1",
                            content: [
                                InfoModelDetail(
                                    title: "Subtitle",
                                    content: ["content1", "content1"
                        ])
                    ])
                ]),
                    InfoContentItemObject(
                    name: "info2",
                    models: [
                        InfoModel(
                            title: "Title2",
                            content: [
                                InfoModelDetail(
                                    title: "Subtitle2",
                                    content: ["content1", "content1"
                        ])
                    ])
                ])
            ]),
            action: ActionContentObject(
                content: [
                    ActionContentItemObject(
                        name: "Action random 1",
                        models: [
                            ActionModel(
                                title: "Action 1",
                                subTitle: "Action 1 sub",
                                type: .HappyWeekend
                            ),
                            ActionModel(
                                title: "Action 2",
                                subTitle: "Action 3 sub",
                                type: .HardDayNight
                            ),
                        ]
                    ),
                    ActionContentItemObject(
                        name: "Action random 2",
                        models: [
                            ActionModel(
                                title: "Action 1",
                                subTitle: "Action 1 sub",
                                type: .HappyWeekend
                            ),
                            ActionModel(
                                title: "Action 2",
                                subTitle: "Action 3 sub",
                                type: .HardDayNight
                            ),
                        ]
                    ),
                ]
            ),
            play: PlayContentObject(
                content: [
                    PlayContentItemObject(
                        name: "Play 1",
                        models: [
                            "Item info 1", "Item info 2"
                        ])
                ]
            ))
    }
}
