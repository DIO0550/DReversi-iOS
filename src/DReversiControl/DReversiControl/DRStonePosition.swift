//
//  DRStonePosition.swift
//  DRevesiControl
//
//  Created by DIO on 2019/12/18.
//  Copyright © 2019 DIO. All rights reserved.
//

import UIKit

public struct DRStonePosition {
    public var column: Int
    public var row: Int
    
    public init(column: Int, row: Int) {
        self.column = column
        self.row = row
    }
    
    public func isOutOfRange() -> Bool {
        if self.column < 0 || self.column >= DReversiControlConst.BlockCount { return true }
        if self.row < 0 || self.row >= DReversiControlConst.BlockCount { return true }
        
        return false
    }
    
    public mutating func incrementColumnRow() {
        self.column += 1
        self.row += 1
    }
    
    public mutating func incrementColumn() {
        self.column += 1
    }
    
    public mutating func incrementRow() {
        self.row += 1
    }
    
    public mutating func decrementColumnRow() {
        self.column -= 1
        self.row -= 1
    }
    
    public mutating func decrementColumn() {
        self.column -= 1
    }
    
    public mutating func decrementRow() {
        self.row -= 1
    }
    
    public mutating func incrementColumnDecrementRow() {
        self.column += 1
        self.row -= 1
    }
    
    public mutating func decrementColumnIncrementRow() {
        self.column -= 1
        self.row += 1
    }
}
