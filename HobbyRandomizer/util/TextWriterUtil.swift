//
//  TextWriterUtil.swift
//  HobbyRandomizer
//
//  Created by ICoon on 22.06.2022.
//

import Foundation

/**
 create /write test
 read test
 
 export notes in text
 import notes in text
 */
class TextWriterUtil{
    
    
    
    private let log = "TextWritterLog"
    
    private let fileName =  "test.txt"
    

    
    func writeTest(text: String){
        
        guard let fileURL = getFileUrl() else {
            printLog("file url is nil !")
            return
        }
       
        
        do {
            try text.write(to: fileURL, atomically: false, encoding: .utf8)
            printLog("Write: success!")
        }
        catch let error {
            printLog("Error writting: \(error.localizedDescription)")
        }
    }
    
    func readTest(){
        
        guard let fileURL = getFileUrl() else {
            printLog("file url is nil !")
            return
        }
        
        do {
            let text2 = try String(contentsOf: fileURL, encoding: .utf8)
            printLog("Read success: Text: \(text2)")
        }
        
        catch let error{
            printLog("Error reading: \(error.localizedDescription)")
        }
    }
    
    func readAllFilenames() -> [String]{
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{
            printLog("DocumentUrl nil")
            return []
        }
        
        do {
            let fileURLs: [URL] = try FileManager.default.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            
            return  fileURLs.map{ $0.lastPathComponent}
        } catch let error{
            printLog("Error while read directories: \(error.localizedDescription)")
            return []
        }
    }
    
    private func getFileUrl() -> URL? {
        guard let dir =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{
            return nil
        }
        return dir.appendingPathComponent(fileName)
    }
    
    private func printLog(_ value: String){
        print("[ \(log) ] : \(value)")
    }
    
}
