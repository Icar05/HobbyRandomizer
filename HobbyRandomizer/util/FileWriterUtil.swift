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
    
    
    func removeItem(fileName: String) -> Bool {
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
    
    func writeText(fileName: String, text: String){
        
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
    
    func importModelsAsJson(fileName: String) -> [RandItemCellModel]?{
        guard let data = readFile(fileName: fileName).data(using: String.Encoding.utf8) else {
            printLog("can't read data from string ...")
            return nil
        }
        return decodeData(data: data)
    }
    
    func importModels(fileName: String) -> Any?{
        let input = readFile(fileName: fileName)
        return mainParcer.parseString(input: input)
    }
    
    @discardableResult
    func exportModels(fileName: String, models: [RandItemCellModel]) -> Bool{
        
        guard let data = encodeData(models: models),
              let text = String(data: data, encoding: String.Encoding.utf8) else{
            printLog("trouble with encoding ...")
            return false
        }
       
        self.writeText(fileName: fileName, text: text)
        return true
    }
    
    func readAllAppFilenames() -> [FileInfo]{
        
        do {
            let url = try FileManager.default.url(for: .applicationSupportDirectory, in: .localDomainMask, appropriateFor: nil, create: false)
            return readAllFilenames(url: url)
        } catch let error {
            printLog("Error while reading app url: \(error)")
            return []
        }
    }
    
    func readAllFilenames() -> [FileInfo]{
        
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{
            printLog("DocumentUrl nil")
            return []
        }
        
        return readAllFilenames(url: documentsURL)
    }
    
    private func readAllFilenames(url: URL) -> [FileInfo]{
        do {
            let fileURLs: [URL] = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
            
            return  fileURLs.map{ FileInfo(shortName: $0.lastPathComponent, fullName: $0.path)}
        } catch let error{
            printLog("Error while read directories: \(error.localizedDescription)")
            return []
        }
    }
    
    private func decodeData(data: Data) -> [RandItemCellModel]?{
        do {
            return try JSONDecoder().decode([RandItemCellModel].self, from: data)
        } catch let error{
            printLog("Error decode data:  (\(error))")
        }
        return nil
    }
    
    private func encodeData(models: [RandItemCellModel]) -> Data?{
        do {
            return try JSONEncoder().encode(models)
        } catch let error {
            printLog("Error encode data:  (\(error))")
        }
        return nil
    }
    
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
