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
    func navigateAlert(start: UIViewController, destination: UIViewController)
    func getInitialController() -> InitialViewController
    func getMenuScreen() -> UIViewController
    func getCasinoScreen() -> UIViewController
    func getDebugScreen() -> UIViewController
    func getTestScreen() -> UIViewController
    func getCreateScreen(storage: UserDefaultStorage, fileUtil: FileWriterUtil, alertUtil: AlertUtil) -> UIViewController
    func getRandomizerScreen(models: [ActionModel], alertUtil: AlertUtil) -> UIViewController
    func getShowScreen(storage: UserDefaultStorage, type: ItemType) -> UIViewController
    func getFilesScreen(filesUtil: FileWriterUtil, alertUtil: AlertUtil) -> UIViewController
    func getFilesDetailScreen(folderName: String, filesUtil: FileWriterUtil, alertUtil: AlertUtil, jsonDecoder: JsonDecoder) -> UIViewController
    func getDisplayActionDataScreen(data: [ActionModel], storage: UserDefaultStorage, alertUtil: AlertUtil) -> UIViewController
    func getDisplayInfoDataScreen(data: [InfoModel]) -> UIViewController
    func getDisplayRawDataScreen(data: [String]) -> UIViewController
    func getSettingScreen(storage: UserDefaultStorage) -> UIViewController
    func getNotesInstructionScreen() -> UIViewController
    func getSelectColorScreen(storage: UserDefaultStorage) -> UIViewController
    func getOpenFileScreen(openFileUtil: OpenFileUtil, alertUtil: AlertUtil, importUtil: ImportUtil) -> UIViewController
    func getYesNoScreen(storage: UserDefaultStorage) -> UIViewController
    func getTimerScreen(storage: UserDefaultStorage, timerUtil: TimerUtil) -> UIViewController
    func getSelectColorAlert(model: UISelectionDialogModel) -> UIViewController    
}
