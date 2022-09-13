//
//  ImportUtil.swift
//  RS
//
//  Created by ICoon on 14.09.2022.
//

import Foundation

public final class ImportUtil{
    
    
    
    private let fileWriteUtil: FileWriterUtil
    
    private let jsonDecoder: JsonDecoder
    
    init(fileWriteUtil: FileWriterUtil, jsonDecoder: JsonDecoder){
        self.fileWriteUtil = fileWriteUtil
        self.jsonDecoder = jsonDecoder
    }
    
    
    func importData(data: Data, callback: @escaping (Bool) -> Void){
        guard let appContent = jsonDecoder.decode(data: data, type: AppContent.self) else {
            return
        }
        
        self.importInfo(appContent.info)
        self.importAction(appContent.action)
        self.importPlay(appContent.play)
        
        callback(true)
    }
    
    private func importInfo(_ info: InfoContentObject){
        info.content.forEach{
            let jsonString = String(data: jsonDecoder.modelToData(model: $0.models)!, encoding: .utf8)
            self.fileWriteUtil.writeFile(
                fileName: $0.name,
                text: jsonString!,
                directory: FolderName.Info.rawValue
            )
        }
    }
    
    private func importAction(_ action: ActionContentObject){
        action.content.forEach{
            let jsonString = String(data: jsonDecoder.modelToData(model: $0.models)!, encoding: .utf8)
            self.fileWriteUtil.writeFile(
                fileName: $0.name,
                text: jsonString!,
                directory: FolderName.Action.rawValue
            )
        }
    }
    
    private func importPlay(_ play: PlayContentObject){
        play.content.forEach{
            let jsonString = String(data: jsonDecoder.modelToData(model: $0.models)!, encoding: .utf8)
            self.fileWriteUtil.writeFile(
                fileName: $0.name,
                text: jsonString!,
                directory: FolderName.Play.rawValue
            )
        }
    }
    
    
}
