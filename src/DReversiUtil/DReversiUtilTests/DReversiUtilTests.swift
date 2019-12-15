//
//  DReversiUtilTests.swift
//  DReversiUtilTests
//
//  Created by DIO on 2019/12/15.
//  Copyright © 2019 DIO. All rights reserved.
//

import XCTest
@testable import DReversiUtil

class DReversiUtilTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetValue() {
        let array2D: DRArray2D = DRArray2D.init(width: 10, height: 10, value: 10)
        array2D.setValue(x: 1, y: 1, value: 2)
        let value = array2D.value(x: 1, y: 1)
        XCTAssertTrue(value! as! Int == 2)
    }
}
