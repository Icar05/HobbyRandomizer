//
//  TextWriterUtil.swift
//  HobbyRandomizer
//
//  Created by ICoon on 22.06.2022.
//

import Foundation
import PDFKit


enum FolderName: String, CaseIterable{
    case Action = "Action"
    case Info = "Info"
    case Play = "Play"
}


struct FileInfo{
    var shortName: String
    var fullName: String
    var folderName: String
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
    
    func readAllFileNamesInFolder(folderName: String) -> [FileInfo]{
            
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName) else{
                printLog("DocumentUrl nil")
                return []
            }
            
            do {
                let fileURLs: [URL] = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
                
                return  fileURLs.map{ FileInfo(shortName: $0.lastPathComponent, fullName: $0.path, folderName: folderName)}
            } catch let error{
                printLog("Error while read directories: \(error.localizedDescription)")
                return []
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
            
            return  fileURLs.map{ FileInfo(shortName: $0.lastPathComponent, fullName: $0.path, folderName: "RS")}
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
    
    func readFile(fileName: String, dirName: String) -> String{
        guard let fileURL = getFileUrl(fileName: fileName, directoryName: dirName) else {
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
    
    
    func writeFile(fileName: String, text: String, directory: String){
        
        guard let dir: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(directory) else {
            return
        }
    
        if !FileManager.default.fileExists(atPath: dir.absoluteString) {
            try! FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true, attributes: nil)
        }
        
        let fileURL = dir.appendingPathComponent(fileName)
    
        self.writeFile(fileURL: fileURL, text: text)

    }
        
    func writeFile(fileName: String, text: String){
        
        guard let fileURL = getFileUrl(fileName: fileName) else {
            printLog("file url is nil !")
            return
        }
        
        self.writeFile(fileURL: fileURL, text: text)
       
    }
    
    private func writeFile(fileURL: URL, text: String){
        do {
            try text.write(to: fileURL, atomically: false, encoding: .utf8)
            printLog("Write: success!")
        }
        catch let error {
            printLog("Error writting: \(error.localizedDescription)")
        }
    }
    
    
    
//    func creatSubFolders(){
//        let folderNames = FolderName.allCases
//
//        for item in folderNames{
//            self.createFolderIfNotExist(folderName: item.rawValue)
//        }
//
//    }
//
//
//    @discardableResult
//    private func createFolderIfNotExist(folderName: String) -> Bool{
//
//        guard let url: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName) else {
//            return false
//        }
//
//        if !FileManager.default.fileExists(atPath: url.absoluteString) {
//            try! FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
//            return true
//        }
//
//        return false
//    }
    
    
    /**
     base url for RS
     */
    
    
    private func getFileUrl(fileName: String) -> URL? {
        guard let dir =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{
            return nil
        }
        return dir.appendingPathComponent(fileName)
    }
    
    private func getFileUrl(fileName: String, directoryName: String) -> URL? {
        guard let dir =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{
            return nil
        }
        return dir.appendingPathComponent(directoryName).appendingPathComponent(fileName)
    }
    
    private func printLog(_ value: String){
        print("[ \(log) ] : \(value)")
    }
    
}
