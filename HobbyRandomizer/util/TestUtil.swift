//
//  TestUtil.swift
//  HobbyRandomizer
//
//  Created by ICoon on 23.06.2022.
//

import Foundation

class TestUtil{
    
    func createMockModels() -> [RandItemCellModel]{
        return [
            RandItemCellModel(title: "Test 1", subTitle: "Test Item 1", type: .necessary),
            RandItemCellModel(title: "Test 2", subTitle: "Test Item 2", type: .necessary),
            RandItemCellModel(title: "Test 3", subTitle: "Test Item 3", type: .necessary),
        ]
    }
    
}
