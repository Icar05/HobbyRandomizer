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
    func getCreateScreen(storage: UserDefaultStorage, fileUtil: FileWriterUtil) -> UIViewController
    func getRandomizerScreen(models: [RandItemCellModel]) -> UIViewController
    func getShowScreen(storage: UserDefaultStorage, type: ItemType) -> UIViewController
    func getFilesScreen(filesUtil: FileWriterUtil) -> UIViewController
    func getDisplayActionDataScreen(data: [RandItemCellModel], storage: UserDefaultStorage) -> UIViewController
    func getDisplayInfoDataScreen(data: [InfoModel], storage: UserDefaultStorage) -> UIViewController
    func getDisplayRawDataScreen(data: String, storage: UserDefaultStorage) -> UIViewController
}
