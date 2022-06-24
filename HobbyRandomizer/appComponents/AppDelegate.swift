//
//  AppDelegate.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 12.10.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?
    
    private let navigator: Navigator = NavigatorImpl()
    
    private let storage: UserDefaultStorage = UserDefaultStorage()
    
    private let fileUtil: FileWriterUtil = FileWriterUtil()
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.navigator.setupInitialViewController(window: window!)
        self.writeTest()
        self.writeTestData()
            
        return true
    }
    
    func getNavigator() -> Navigator{
        return self.navigator
    }
    
    func getStorage() -> UserDefaultStorage{
        return self.storage
    }
    
    func getFileUtil() -> FileWriterUtil{
        return fileUtil
    }
    
    func writeTest(){
        let time = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
        self.fileUtil.writeText(fileName: "test.txt", text: "[ This is a test... \(time) ]")
    }
    
    func writeTestData(){
        let testObjects = TestUtil().createMockModels()
        self.fileUtil.exportModels(fileName: "testExport.txt", models: testObjects)
    }

}

