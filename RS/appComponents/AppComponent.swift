//
//  AppComponent.swift
//  RS
//
//  Created by ICoon on 29.07.2022.
//

import Foundation

class AppComponent{
    

    
    private let navigator: Navigator = NavigatorImpl()
    
    private let storage: UserDefaultStorage = UserDefaultStorage()
    
    private let fileUtil: FileWriterUtil = FileWriterUtil()
    
    private var testUtil: TestUtil? = nil
    
    private let alertUtil = AlertUtil()
    
    private let notificationUtil = NotificationUtil()
    
    
    
    
    init(){
        self.testUtil = TestUtil(fileUtil: fileUtil)
    }
    
    func getTestUtil() -> TestUtil{
        return self.testUtil!
    }
    
    func getSoundUtil(sound: SoundCaf) -> SoundUtil{
        let model = getStorage().getAppPreferences()
        return SoundUtil(enable: model.isEnabledSound, volume: model.volume, sound: sound)
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
    
    func getNotificationUtil() -> NotificationUtil{
        return notificationUtil
    }
    
    func getAlertUtil() -> AlertUtil{
        return alertUtil
    }
}
