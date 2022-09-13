//
//  AppComponent.swift
//  RS
//
//  Created by ICoon on 29.07.2022.
//

import Foundation

class AppComponent{
    

    private let jsonDecoder: JsonDecoder = JsonDecoder()
    
    private let navigator: Navigator = NavigatorImpl()
    
    private let storage: UserDefaultStorage = UserDefaultStorage()
    
    private let fileUtil: FileWriterUtil = FileWriterUtil()
    
    private let alertUtil = AlertUtil()
    
    private let notificationUtil = NotificationUtil()
    
    private let openFileUtil: OpenFileUtil = OpenFileUtil()
    
    private let testUtil: TestUtil
    
    private let elapsedTimeUtil : ElapsedTimeUtil
    
    private let timerUtil: TimerUtil
    
    private let importUtil: ImportUtil
    
    
    
    init(){
        self.importUtil = ImportUtil(fileWriteUtil: fileUtil, jsonDecoder: jsonDecoder)
        self.testUtil = TestUtil(fileUtil: fileUtil)
        self.elapsedTimeUtil = ElapsedTimeUtil(storage: storage)
        self.timerUtil = TimerUtil(
            notificationUtil: notificationUtil,
            soundUtil: SoundUtil(enable: true, volume: 1.0, sound: SoundUtil.getSoundForTimer()),
            elapsedTimeUtil: elapsedTimeUtil)
    }
    
    func getTestUtil() -> TestUtil{
        return self.testUtil
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
    
    func getElapsedTimeUtil() -> ElapsedTimeUtil{
        return elapsedTimeUtil
    }
    
    func getTimerUtil() -> TimerUtil{
        return timerUtil
    }
    
    func getOpenFileUtil() -> OpenFileUtil{
        return self.openFileUtil
    }
    
    func getImportUtil() -> ImportUtil {
        return self.importUtil
    }
    
    func getJsonDecoder() -> JsonDecoder{
        return self.jsonDecoder
    }
}
