//
//  OpenFIleProvider.swift
//  RS
//
//  Created by ICoon on 13.09.2022.
//

import Foundation

public final class OpenFileProvider{
    
    
    private let log = "OpenFileProvider"
    
    
    func readAllFilenames() -> [FileInfo]{
        
        guard let url = FileManager.default.urls(
            for: .documentDirectory,
               in: .userDomainMask).first else{
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
    
    private func printLog(_ value: String){
        print("[ \(log) ] : \(value)")
    }
}
