//
//  TextWriterUtil.swift
//  HobbyRandomizer
//
//  Created by ICoon on 22.06.2022.
//

import Foundation
import PDFKit


struct FileInfo{
    var shortName: String
    var fullName: String
}

/**
 create /write test
 read test
 
 export notes in text
 import notes in text
 */
class FileWriterUtil{
    
    
    
    private let log = "TextWritterLog"
    
    private let mainParcer = MainParser()
    
    private let jsonDecoder = JsonDecoder()
    
    
    
    /**
     export and import
     */
    @discardableResult
    func exportDataAsJson(fileName: String, models: [RandItemCellModel]) -> Bool{
        
        guard let data = jsonDecoder.encodeData(models: models),
              let text = String(data: data, encoding: String.Encoding.utf8) else{
                  printLog("trouble with encoding ...")
                  return false
              }
        
        self.writeFile(fileName: fileName, text: text)
        return true
    }
    
    func importDataAsJson(fileName: String) -> [RandItemCellModel]?{
        guard let data = readFile(fileName: fileName).data(using: String.Encoding.utf8) else {
            printLog("can't read data from string ...")
            return nil
        }
        return jsonDecoder.decodeData(data: data)
    }
    
    func importModels(fileName: String) -> Any?{
        let input = readFile(fileName: fileName)
        
        
        guard let data: Data = input.data(using: String.Encoding.utf8),
              let result: [RandItemCellModel] = jsonDecoder.decodeData(data: data) else {
                  return mainParcer.parseString(input: input)
              }
        
        return result
    }
    
    /**
     remove file from folder RS
     */
    func removeFileByFileName(fileName: String) -> Bool {
        guard let fileURL = getFileUrl(fileName: fileName) else {
            printLog("file url is nil !")
            return false
        }
        
        do{
            try FileManager.default.removeItem(at: fileURL)
            return true
        } catch let error {
            printLog("Error while removing file: \(error.localizedDescription)")
            return false
        }
        
    }
    /**
     methods for reading all files in directory RS
     */
    func readAllFilenames() -> [FileInfo]{
        
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{
            printLog("DocumentUrl nil")
            return []
        }
        
        do {
            let fileURLs: [URL] = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
            
            return  fileURLs.map{ FileInfo(shortName: $0.lastPathComponent, fullName: $0.path)}
        } catch let error{
            printLog("Error while read directories: \(error.localizedDescription)")
            return []
        }
    }
    
    /*
     base read / write methods
     */
    func readFile(fileName: String) -> String{
        
        guard let fileURL = getFileUrl(fileName: fileName) else {
            printLog("file url is nil !")
            return ""
        }
        
        do {
            return  try String(contentsOf: fileURL, encoding: .utf8)
        }
        
        catch let error{
            printLog("Error reading: \(error.localizedDescription)")
            return ""
        }
    }
    
    func writeFile(fileName: String, text: String){
        
        guard let fileURL = getFileUrl(fileName: fileName) else {
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
    
    /**
     base url for RS
     */
    private func getFileUrl(fileName: String) -> URL? {
        guard let dir =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{
            return nil
        }
        return dir.appendingPathComponent(fileName)
    }
    
    private func printLog(_ value: String){
        print("[ \(log) ] : \(value)")
    }
    
}
