//
//  Navigator.swift
//  HobbyRandomizer
//
//  Created by ICoon on 07.06.2022.
//

import Foundation

protocol Navigator{
    func setupInitialViewController(window: UIWindow)
    func navigate(start: UIViewController, destination: UIViewController)
    func getMenuScreen() -> UIViewController
    func getCasinoScreen() -> UIViewController
    func getDebugScreen() -> UIViewController
    func getCreateScreen(storage: UserDefaultStorage) -> UIViewController
    func getRandomizerScreen(models: [RandItemCellModel]) -> UIViewController
    func getShowScreen(storage: UserDefaultStorage, type: ItemType) -> UIViewController
    func getFilesScreen(filesUtil: FileWriterUtil) -> UIViewController
    func getDisplayDataScreen(data: String, storage: UserDefaultStorage) -> UIViewController
    func getDisplayDataScreen(data: [RandItemCellModel], storage: UserDefaultStorage) -> UIViewController
}
