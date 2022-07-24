//
//  TestUtil.swift
//  HobbyRandomizer
//
//  Created by ICoon on 23.06.2022.
//

import Foundation

class TestUtil{
    
    let fileUtil: FileWriterUtil
    
    init(fileUtil: FileWriterUtil){
        self.fileUtil = fileUtil
    }
    
    func startTest(){}
    
    private func writeTest(){
        let time = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
        self.fileUtil.writeFile(fileName: "test.txt", text: "[ This is a test... \(time) ]")
    }
    
    private func writeTestData(){
        let testObjects = createMockModels()
        self.fileUtil.exportDataAsJson(fileName: "testExport.txt", models: testObjects)
    }
    
    private func createMockModels() -> [RandItemCellModel]{
        return [
            RandItemCellModel(title: "Test 1", subTitle: "Test Item 1", type: .ToDo),
            RandItemCellModel(title: "Test 2", subTitle: "Test Item 2", type: .HardDayNight),
            RandItemCellModel(title: "Test 3", subTitle: "Test Item 3", type: .HappyWeekend),
        ]
    }
    
}
