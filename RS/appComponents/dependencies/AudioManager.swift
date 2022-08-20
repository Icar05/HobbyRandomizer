////
////  AudioManager.swift
////  SyncLifeWatchClient
////
////  Created by Alexandr Galiatkin on 8/6/19.
////  Copyright © 2019 Edsson. All rights reserved.
////
//
//import Foundation
//
//#warning("use it to move files")
//class AudioManager {
//
//    var filesToLoad: [FileDetailModel] = []
//    var audioFiles: [AudioModel] = []
//
//    private var needLoadHeaders = true
//
//    func addModel(data: Data){
//        self.audioFiles.append(AudioModel(name: getNextFileName(), data: data))
//        self.filesToLoad.removeFirst()
//    }
//
//    func getNeedLoadHeaders() -> Bool{
//        return needLoadHeaders
//    }
//
//    func setNeedLoadHeaders(value: Bool){
//        self.needLoadHeaders = value
//    }
//
//
//    func loadAudiosNotFinished() -> Bool{
//        return filesToLoad.count > 0
//    }
//
//
//    func getNextFileName() -> String{
//        return (filesToLoad.first?.name)!
//    }
//
//
//    //player.playSound(name: array[0], ext: array[1])
//    func createAudioFiles(){
//        audioFiles.forEach{ storeAudio(model: $0)}
//    }
//
//
//
//
//    private func storeAudio(model: AudioModel){
//        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//
//            let fileURL = dir.appendingPathComponent(model.name)
//            do {
//                try model.data.write(to: fileURL, options: [])
//            }
//            catch let error{
//                print("!!! ---------- Error while writing file "+error.localizedDescription)
//            }
//        }
//    }
//
//
//
//}
