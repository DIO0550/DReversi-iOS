//
//  DRStonePositionTests.swift
//  DReversiControlTests
//
//  Created by DIO on 2020/02/22.
//  Copyright © 2020 DIO. All rights reserved.
//

import XCTest
@testable import DReversiControl

class DRStonePositionTests: XCTestCase {
    
    override func setUp() {
    }
    
    override func tearDown() {
    }
    
    func testIsOutOfRange() {
        let stonePosition1 = DRStonePosition(column: 1, row: -1)
        XCTAssertTrue(stonePosition1.isOutOfRange())
        
        let stonePosition2 = DRStonePosition(column: -1, row: 1)
        XCTAssertTrue(stonePosition2.isOutOfRange())
        
        let stonePosition3 = DRStonePosition(column: 1, row: 8)
        XCTAssertTrue(stonePosition3.isOutOfRange())
        
        let stonePosition4 = DRStonePosition(column: 8, row: 1)
        XCTAssertTrue(stonePosition4.isOutOfRange())
        
        let stonePosition5 = DRStonePosition(column: 1, row: 7)
        XCTAssertFalse(stonePosition5.isOutOfRange())
        
        let stonePosition6 = DRStonePosition(column: 7, row: 1)
        XCTAssertFalse(stonePosition6.isOutOfRange())
        
        let stonePosition7 = DRStonePosition(column: 1, row: 0)
        XCTAssertFalse(stonePosition7.isOutOfRange())
        
        let stonePosition8 = DRStonePosition(column: 0, row: 1)
        XCTAssertFalse(stonePosition8.isOutOfRange())
    }
    
    func testEqualable() {
        let stonePosition1 = DRStonePosition(column: 1, row: 1)
        let stonePosition2 = DRStonePosition(column: 1, row: 1)
        let stonePosition3 = DRStonePosition(column: 2, row: 1)
        
        XCTAssertTrue(stonePosition1 == stonePosition2)
        XCTAssertFalse(stonePosition1 != stonePosition2)
        XCTAssertFalse(stonePosition1 == stonePosition3)
    }
    
    func testIncrementColumnRow() {
        var stonePosition = DRStonePosition(column: 1, row: 1)
        stonePosition.incrementColumnRow()
        XCTAssertEqual(stonePosition.column, 2)
        XCTAssertEqual(stonePosition.row, 2)
    }
    
    func testIncrementColumn() {
        var stonePosition = DRStonePosition(column: 1, row: 1)
        stonePosition.incrementColumn()
        XCTAssertEqual(stonePosition.column, 2)
        XCTAssertEqual(stonePosition.row, 1)
    }
    
    func testIncrementRow() {
        var stonePosition = DRStonePosition(column: 1, row: 1)
        stonePosition.incrementRow()
        XCTAssertEqual(stonePosition.column, 1)
        XCTAssertEqual(stonePosition.row, 2)
    }
    
    func testDecrementColumnRow() {
        var stonePosition = DRStonePosition(column: 1, row: 1)
        stonePosition.decrementColumnRow()
        XCTAssertEqual(stonePosition.column, 0)
        XCTAssertEqual(stonePosition.row, 0)
    }
    
    func testDecrementColumn() {
        var stonePosition = DRStonePosition(column: 1, row: 1)
        stonePosition.decrementColumn()
        XCTAssertEqual(stonePosition.column, 0)
        XCTAssertEqual(stonePosition.row, 1)
    }
    
    func testDecrementRow() {
        var stonePosition = DRStonePosition(column: 1, row: 1)
        stonePosition.decrementRow()
        XCTAssertEqual(stonePosition.column, 1)
        XCTAssertEqual(stonePosition.row, 0)
    }
    
    func testIncrementColumnDecrementRow() {
        var stonePosition = DRStonePosition(column: 1, row: 1)
        stonePosition.incrementColumnDecrementRow()
        XCTAssertEqual(stonePosition.column, 2)
        XCTAssertEqual(stonePosition.row, 0)
    }
    
    func testDecrementColumnIncrementRow() {
        var stonePosition = DRStonePosition(column: 1, row: 1)
        stonePosition.decrementColumnIncrementRow()
        XCTAssertEqual(stonePosition.column, 0)
        XCTAssertEqual(stonePosition.row, 2)
    }
}
