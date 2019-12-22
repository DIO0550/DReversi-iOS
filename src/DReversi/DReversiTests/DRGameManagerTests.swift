//
//  DRGameManagerTests.swift
//  DReversiTests
//
//  Created by DIO on 2019/12/22.
//  Copyright © 2019 DIO. All rights reserved.
//

import XCTest
@testable import DReversiControl
@testable import DReversi

class DRGameManagerTests: XCTestCase {
    override func setUp() {
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    private func initializeStones(gameManager: DRGameManager, boardView: DRBoardView) {
        gameManager.addStone(stonePosition: DRStonePosition(column: 3, row: 3),
                             boardView: boardView,
                             stoneType: .WHITE_STONE)
        gameManager.addStone(stonePosition: DRStonePosition(column: 4, row: 3),
                             boardView: boardView,
                             stoneType: .BLACK_STONE)
        gameManager.addStone(stonePosition: DRStonePosition(column: 4, row: 4),
                             boardView: boardView,
                             stoneType: .WHITE_STONE)
        gameManager.addStone(stonePosition: DRStonePosition(column: 3, row: 4),
                             boardView: boardView,
                             stoneType: .BLACK_STONE)
    }

    func testAddStone() {
        let boardView: DRBoardView = DRBoardView.init(frame: CGRect(x: 0, y: 0, width: 200, height: 200));
        let gameManager: DRGameManager = DRGameManager()
        
        self.initializeStones(gameManager: gameManager, boardView: boardView)
        
    }
    
    func testReverseLeftTopBlack() {
        let boardView: DRBoardView = DRBoardView.init(frame: CGRect(x: 0, y: 0, width: 200, height: 200));
        let gameManager: DRGameManager = DRGameManager()
        
        self.initializeStones(gameManager: gameManager, boardView: boardView)
        
    }
    
    func testReverseTop() {
        
    }
    
    func testReversiRightTop() {
        
    }
    

}
