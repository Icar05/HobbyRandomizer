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
    func getCasinoScreen(storage: UserDefaultStorage) -> UIViewController
    func getDebugScreen(storage: UserDefaultStorage) -> UIViewController
    func getCreateScreen(storage: UserDefaultStorage, fileUtil: FileWriterUtil) -> UIViewController
    func getRandomizerScreen(storage: UserDefaultStorage, models: [RandItemCellModel]) -> UIViewController
    func getShowScreen(storage: UserDefaultStorage, type: ItemType) -> UIViewController
    func getFilesScreen(filesUtil: FileWriterUtil) -> UIViewController
    func getDisplayActionDataScreen(data: [RandItemCellModel], storage: UserDefaultStorage) -> UIViewController
    func getDisplayInfoDataScreen(data: [InfoModel]) -> UIViewController
    func getDisplayRawDataScreen(data: String) -> UIViewController
    func getSettingScreen(storage: UserDefaultStorage) -> UIViewController
    func getNotesInstructionScreen() -> UIViewController
    func getSelectColorScreen(storage: UserDefaultStorage) -> UIViewController
}
