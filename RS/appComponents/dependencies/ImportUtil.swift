//
//  ImportUtil.swift
//  RS
//
//  Created by ICoon on 14.09.2022.
//

import Foundation

public final class ImportUtil{
    
    
    
    private let fileWriteUtil: FileWriterUtil
    
    init(fileWriteUtil: FileWriterUtil){
        self.fileWriteUtil = fileWriteUtil
    }
    
    
    func importData(data: Data, callback: @escaping (Bool) -> Void){
        guard let appContent = decode(data: data, type: AppContent.self) else {
            return
        }
        
        self.importInfo(appContent.info)
        self.importAction(appContent.action)
        self.importPlay(appContent.play)
        
        callback(true)
    }
    
    private func importInfo(_ info: InfoContentObject){
        info.content.forEach{
            let jsonString = String(data: modelToData(model: $0.models)!, encoding: .utf8)
            self.fileWriteUtil.writeFile(
                fileName: $0.name,
                text: jsonString!,
                directory: FolderName.Info.rawValue
            )
        }
    }
    
    private func importAction(_ action: ActionContentObject){
        action.content.forEach{
            let jsonString = String(data: modelToData(model: $0.models)!, encoding: .utf8)
            self.fileWriteUtil.writeFile(
                fileName: $0.name,
                text: jsonString!,
                directory: FolderName.Action.rawValue
            )
        }
    }
    
    private func importPlay(_ play: PlayContentObject){
        play.content.forEach{
            let jsonString = String(data: modelToData(model: $0.models)!, encoding: .utf8)
            self.fileWriteUtil.writeFile(
                fileName: $0.name,
                text: jsonString!,
                directory: FolderName.Play.rawValue
            )
        }
    }
    
    private func modelToData<T>(model: T) -> Data? where T : Codable{
        do {
            return try JSONEncoder().encode(model)
        } catch let error {
            print("Error encode data:  (\(error))")
            return nil
        }
    }
    
    private func decode<T>(data: Data, type: T.Type) -> T? where T: Codable{
        do{
            return  try JSONDecoder().decode(T.self, from: data) as T
        } catch  {
            
            print("error: \(error)")
            return nil
        }
    }
    
}
