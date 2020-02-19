//
//  DRGameManager.swift
//  DReversi
//  ゲーム管理クラス
//  Created by DIO on 2019/12/19.
//  Copyright © 2019 DIO. All rights reserved.
//

import UIKit
import DReversiUtil
import DReversiControl

public class DRGameManager {
    
    public private(set) var stones:DRArray2D
    
    init() {
        self.stones = DRArray2D.init(width: DReversiControlConst.BlockCount,
                                     height:  DReversiControlConst.BlockCount,
                                     value: nil)
    }
    
    public func canPutStonePositions(stoneType: DRStoneType) -> [DRStonePosition] {
        var positions: [DRStonePosition] = []
        for row in 0 ..< DReversiControlConst.BlockCount {
            for column in 0 ..< DReversiControlConst.BlockCount {
                let position: DRStonePosition = DRStonePosition(column: column, row: row)
                if self.canPutReversePosition(stonePosition: position, stoneType: stoneType) {
                    positions.append(position)
                }
            }
        }
        
        return positions
    }
    
    public func canPutPosition(stonePosition: DRStonePosition, stoneType: DRStoneType) -> Bool {
        if stonePosition.isOutOfRange() { return false }
        if self.stones.value(x: stonePosition.column, y: stonePosition.row) != nil { return false }
        
        return true
    }
    
    public func canPutReversePosition(stonePosition: DRStonePosition, stoneType: DRStoneType) -> Bool {
        if !canPutPosition(stonePosition: stonePosition, stoneType: stoneType) { return false }
    
        // Top
        if calcReverseCountLeftTop(putPosition: stonePosition, stoneType: stoneType) != 0 { return true }
        if calcReverseCountTop(putPosition: stonePosition, stoneType: stoneType) != 0 { return true }
        if calcReverseCountRightTop(putPosition: stonePosition, stoneType: stoneType) != 0 { return true }
        
        // side
        if calcReverseCountLeft(putPosition: stonePosition, stoneType: stoneType) != 0 { return true }
        if calcReverseCountRight(putPosition: stonePosition, stoneType: stoneType) != 0 { return true }
        
        // bottom
        if calcReverseCountLeftBottom(putPosition: stonePosition, stoneType: stoneType) != 0 { return true }
        if calcReverseCountBottom(putPosition: stonePosition, stoneType: stoneType) != 0 { return true }
        if calcReverseCountRightBottom(putPosition: stonePosition, stoneType: stoneType) != 0 { return true }
        
        return false
    }
    
    public func calcStoneReverseCount(stonePosition: DRStonePosition, stoneType: DRStoneType) -> Int {
        var reverseCount: Int = 0
        
        if !canPutPosition(stonePosition: stonePosition, stoneType: stoneType) { return 0 }
        
        reverseCount += calcReverseCountLeftTop(putPosition: stonePosition, stoneType: stoneType)
        reverseCount += calcReverseCountTop(putPosition: stonePosition, stoneType: stoneType)
        reverseCount += calcReverseCountRightTop(putPosition: stonePosition, stoneType: stoneType)
        
        // side
        reverseCount += calcReverseCountLeft(putPosition: stonePosition, stoneType: stoneType)
        reverseCount += calcReverseCountRight(putPosition: stonePosition, stoneType: stoneType)
        
        // bottom
        reverseCount += calcReverseCountLeftBottom(putPosition: stonePosition, stoneType: stoneType)
        reverseCount += calcReverseCountBottom(putPosition: stonePosition, stoneType: stoneType)
        reverseCount += calcReverseCountRightBottom(putPosition: stonePosition, stoneType: stoneType)
        
        return reverseCount
    }
    
    public func stoneReverseInfos(stoneType: DRStoneType) -> [DRStoneReverseInfo] {
        var stoneReverseInfos: [DRStoneReverseInfo] = []
        for row in 0 ..< DReversiControlConst.BlockCount {
            for column in 0 ..< DReversiControlConst.BlockCount {
                let stonePosition: DRStonePosition = DRStonePosition(column: column, row: row)
                let stoneReverseCount: Int = self.calcStoneReverseCount(stonePosition: stonePosition, stoneType: stoneType)
                if stoneReverseCount == 0 {
                    continue
                }
                let stoneReverseInfo: DRStoneReverseInfo = DRStoneReverseInfo(stonePosition: stonePosition, reverseCount: stoneReverseCount)
                stoneReverseInfos.append(stoneReverseInfo)
            }
        }
        
        return stoneReverseInfos
    }
    
    
    public func reverseStone(putPosition: DRStonePosition, stoneType: DRStoneType) {
        self.reverseLeftTop(putPosition: putPosition, stoneType: stoneType)
        self.reverseTop(putPosition: putPosition, stoneType: stoneType)
        self.reverseRightTop(putPosition: putPosition, stoneType: stoneType)
        self.reverseLeft(putPosition: putPosition, stoneType: stoneType)
        self.reverseRight(putPosition: putPosition, stoneType: stoneType)
        self.reverseLeftBottom(putPosition: putPosition, stoneType: stoneType)
        self.reverseBottom(putPosition: putPosition, stoneType: stoneType)
        self.reverseRightBottom(putPosition: putPosition, stoneType: stoneType)
    }
    
    @discardableResult
    func addStone(stonePosition: DRStonePosition, boardView: DRBoardView, stoneType: DRStoneType) -> Bool {
        if !self.canPutPosition(stonePosition: stonePosition, stoneType: stoneType) { return false }
        
        let stoneRect: CGRect = boardView.stonePositionRect(stonePosition)
        let stoneView: DRStoneView = DRStoneView(frame: stoneRect, type: stoneType)
        
        let success: Bool = self.stones.setValue(x: stonePosition.column, y: stonePosition.row, value: stoneView)
        
        if !success { return false }
        
        boardView.addSubview(stoneView)
        
        return true
    }
    
    public func stoneCount(stoneType: DRStoneType) -> Int {
        var count: Int = 0
        for x in 0..<DReversiControlConst.BlockCount {
            for y in 0..<DReversiControlConst.BlockCount {
                let value = self.stones.value(x: x, y: y)
                guard let stoneView = value as? DRStoneView else { continue }
                count += (stoneView.stoneType == stoneType) ? 1 : 0
            }
        }
        return count
    }
}

extension DRGameManager {
    
    // MARK: reverse method
    
    private func calcReverseCountLeftTop(putPosition: DRStonePosition, stoneType: DRStoneType) -> Int {
        var position = putPosition
        position.decrementColumnRow()
        // 反転できる数
        var reverseCount = 0
        
        // 最初の１つ目をチェック
        let firstValue = self.stones.value(x: position.column, y: position.row)
        guard let firstStoneView = firstValue as? DRStoneView else { return 0 }
        if firstStoneView.stoneType == stoneType { return 0 }
        reverseCount += 1
        position.decrementColumnRow()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { return 0 }
            if stoneView.stoneType == stoneType { return reverseCount }
            reverseCount += 1
            position.decrementColumnRow()
        }
        
        // 挟まれてないなら0
        return 0
    }
    
    private func canReverseLeftTop(putPosition: DRStonePosition, stoneType: DRStoneType) -> Bool {
        var position = putPosition
        position.decrementColumnRow()
        
        // 最初の１つ目をチェック
        let firstValue = self.stones.value(x: position.column, y: position.row)
        guard let firstStoneView = firstValue as? DRStoneView else { return false }
        if firstStoneView.stoneType == stoneType { return false }
        
        position.decrementColumnRow()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { return false }
            if stoneView.stoneType == stoneType { return true }
            position.decrementColumnRow()
        }
        
        return false
    }
    
    
    private func reverseLeftTop(putPosition: DRStonePosition, stoneType: DRStoneType) {
        
        if self.calcReverseCountLeftTop(putPosition: putPosition, stoneType: stoneType) == 0 { return }
        
        var position = putPosition
        position.decrementColumnRow()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { break }
            if stoneView.stoneType != stoneType.reverse() { break }
            stoneView.flipStone()
            position.decrementColumnRow()
        }
    }
    
    private func calcReverseCountTop(putPosition: DRStonePosition, stoneType: DRStoneType) -> Int {
        var position = putPosition
        position.decrementRow()
        // 反転できる数
        var reverseCount = 0
        
        // 最初の１つ目をチェック
        let firstValue = self.stones.value(x: position.column, y: position.row)
        guard let firstStoneView = firstValue as? DRStoneView else { return 0 }
        if firstStoneView.stoneType == stoneType { return 0 }
        reverseCount += 1
        position.decrementRow()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { return 0 }
            if stoneView.stoneType == stoneType { return reverseCount }
            reverseCount += 1
            position.decrementRow()
        }
        
        return 0
    }
    
    private func canReverseTop(putPosition: DRStonePosition, stoneType: DRStoneType) -> Bool {
        var position = putPosition
        position.decrementRow()
        
        // 最初の１つ目をチェック
        let firstValue = self.stones.value(x: position.column, y: position.row)
        guard let firstStoneView = firstValue as? DRStoneView else { return false }
        if firstStoneView.stoneType == stoneType { return false }
        
        position.decrementRow()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { return false }
            if stoneView.stoneType == stoneType { return true }
            position.decrementRow()
        }
        
        return false
    }
    
    private func reverseTop(putPosition: DRStonePosition, stoneType: DRStoneType) {
        
        if self.calcReverseCountTop(putPosition: putPosition, stoneType: stoneType) == 0 { return }
        
        var position = putPosition
        position.decrementRow()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { break }
            if stoneView.stoneType != stoneType.reverse() { break }
            stoneView.flipStone()
            position.decrementRow()
        }
    }
    
    private func calcReverseCountRightTop(putPosition: DRStonePosition, stoneType: DRStoneType) -> Int {
        var position = putPosition
        position.incrementColumnDecrementRow()
        // 反転できる数
        var reverseCount = 0
        
        // 最初の１つ目をチェック
        let firstValue = self.stones.value(x: position.column, y: position.row)
        guard let firstStoneView = firstValue as? DRStoneView else { return 0 }
        if firstStoneView.stoneType == stoneType { return 0 }
        reverseCount += 1
        position.incrementColumnDecrementRow()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { return 0 }
            if stoneView.stoneType == stoneType { return reverseCount }
            reverseCount += 1
            position.incrementColumnDecrementRow()
        }
        
        return 0
    }
    
    private func canReverseRightTop(putPosition: DRStonePosition, stoneType: DRStoneType) -> Bool {
        var position = putPosition
        position.incrementColumnDecrementRow()
        
        // 最初の１つ目をチェック
        let firstValue = self.stones.value(x: position.column, y: position.row)
        guard let firstStoneView = firstValue as? DRStoneView else { return false }
        if firstStoneView.stoneType == stoneType { return false }
        
        position.incrementColumnDecrementRow()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { return false }
            if stoneView.stoneType == stoneType { return true }
            position.incrementColumnDecrementRow()
        }
        
        return false
    }
    
    private func reverseRightTop(putPosition: DRStonePosition, stoneType: DRStoneType) {
        
        if self.calcReverseCountRightTop(putPosition: putPosition, stoneType: stoneType) == 0 { return }
        
        var position = putPosition
        position.incrementColumnDecrementRow()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { break }
            if stoneView.stoneType != stoneType.reverse() { break }
            stoneView.flipStone()
            position.incrementColumnDecrementRow()
        }
    }
    
    private func calcReverseCountLeft(putPosition: DRStonePosition, stoneType: DRStoneType) -> Int {
        var position = putPosition
        position.decrementColumn()
        // 反転できる数
        var reverseCount = 0
        
        // 最初の１つ目をチェック
        let firstValue = self.stones.value(x: position.column, y: position.row)
        guard let firstStoneView = firstValue as? DRStoneView else { return 0 }
        if firstStoneView.stoneType == stoneType { return 0 }
        reverseCount += 1
        position.decrementColumn()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { return 0 }
            if stoneView.stoneType == stoneType { return reverseCount }
            reverseCount += 1
            position.decrementColumn()
        }
        
        return 0
    }
    
    private func canReverseLeft(putPosition: DRStonePosition, stoneType: DRStoneType) -> Bool {
        var position = putPosition
        position.decrementColumn()
        
        // 最初の１つ目をチェック
        let firstValue = self.stones.value(x: position.column, y: position.row)
        guard let firstStoneView = firstValue as? DRStoneView else { return false }
        if firstStoneView.stoneType == stoneType { return false }
        
        position.decrementColumn()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { return false }
            if stoneView.stoneType == stoneType { return true }
            position.decrementColumn()
        }
        
        return false
    }
    
    private func reverseLeft(putPosition: DRStonePosition, stoneType: DRStoneType) {
        
        if self.calcReverseCountLeft(putPosition: putPosition, stoneType: stoneType) == 0 { return }
        
        var position = putPosition
        position.decrementColumn()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { break }
            if stoneView.stoneType != stoneType.reverse() { break }
            stoneView.flipStone()
            position.decrementColumn()
        }
    }
    
    private func calcReverseCountRight(putPosition: DRStonePosition, stoneType: DRStoneType) -> Int {
        var position = putPosition
        position.incrementColumn()
        // 反転できる数
        var reverseCount = 0
        
        // 最初の１つ目をチェック
        let firstValue = self.stones.value(x: position.column, y: position.row)
        guard let firstStoneView = firstValue as? DRStoneView else { return 0 }
        if firstStoneView.stoneType == stoneType { return 0 }
        reverseCount += 1
        position.incrementColumn()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { return 0 }
            if stoneView.stoneType == stoneType { return reverseCount }
            reverseCount += 1
            position.incrementColumn()
        }
        
        return 0
    }
    
    private func canReverseRight(putPosition: DRStonePosition, stoneType: DRStoneType) -> Bool {
        var position = putPosition
        position.incrementColumn()
        
        // 最初の１つ目をチェック
        let firstValue = self.stones.value(x: position.column, y: position.row)
        guard let firstStoneView = firstValue as? DRStoneView else { return false }
        if firstStoneView.stoneType == stoneType { return false }
        
        position.incrementColumn()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { return false }
            if stoneView.stoneType == stoneType { return true }
            position.incrementColumn()
        }
        
        return false
    }
    
    private func reverseRight(putPosition: DRStonePosition, stoneType: DRStoneType) {
        
        if self.calcReverseCountRight(putPosition: putPosition, stoneType: stoneType) == 0 { return }
        
        var position = putPosition
        position.incrementColumn()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { break }
            if stoneView.stoneType != stoneType.reverse() { break }
            stoneView.flipStone()
            position.incrementColumn()
        }
    }
    
    private func calcReverseCountLeftBottom(putPosition: DRStonePosition, stoneType: DRStoneType) -> Int {
        var position = putPosition
        position.decrementColumnIncrementRow()
        // 反転できる数
        var reverseCount = 0
        
        // 最初の１つ目をチェック
        let firstValue = self.stones.value(x: position.column, y: position.row)
        guard let firstStoneView = firstValue as? DRStoneView else { return 0 }
        if firstStoneView.stoneType == stoneType { return 0 }
        reverseCount += 1
        position.decrementColumnIncrementRow()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { return 0 }
            if stoneView.stoneType == stoneType { return reverseCount }
            reverseCount += 1
            position.decrementColumnIncrementRow()
        }
        
        return 0
    }
    
    private func canReverseLeftBottom(putPosition: DRStonePosition, stoneType: DRStoneType) -> Bool {
        var position = putPosition
        position.decrementColumnIncrementRow()
        
        // 最初の１つ目をチェック
        let firstValue = self.stones.value(x: position.column, y: position.row)
        guard let firstStoneView = firstValue as? DRStoneView else { return false }
        if firstStoneView.stoneType == stoneType { return false }
        
        position.decrementColumnIncrementRow()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { return false }
            if stoneView.stoneType == stoneType { return true }
            position.decrementColumnIncrementRow()
        }
        
        return false
    }
    
    private func reverseLeftBottom(putPosition: DRStonePosition, stoneType: DRStoneType) {
        
        if self.calcReverseCountLeftBottom(putPosition: putPosition, stoneType: stoneType) == 0 { return }
        
        var position = putPosition
        position.decrementColumnIncrementRow()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { break }
            if stoneView.stoneType != stoneType.reverse() { break }
            stoneView.flipStone()
            position.decrementColumnIncrementRow()
        }
    }
    
    private func calcReverseCountBottom(putPosition: DRStonePosition, stoneType: DRStoneType) -> Int {
        var position = putPosition
        position.incrementRow()
        // 反転できる数
        var reverseCount = 0
        
        // 最初の１つ目をチェック
        let firstValue = self.stones.value(x: position.column, y: position.row)
        guard let firstStoneView = firstValue as? DRStoneView else { return 0 }
        if firstStoneView.stoneType == stoneType { return 0 }
        reverseCount += 1
        position.incrementRow()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { return 0 }
            if stoneView.stoneType == stoneType { return reverseCount }
            reverseCount += 1
            position.incrementRow()
        }
        
        return 0
    }
    
    private func canReverseBottom(putPosition: DRStonePosition, stoneType: DRStoneType) -> Bool {
        var position = putPosition
        position.incrementRow()
        
        // 最初の１つ目をチェック
        let firstValue = self.stones.value(x: position.column, y: position.row)
        guard let firstStoneView = firstValue as? DRStoneView else { return false }
        if firstStoneView.stoneType == stoneType { return false }
        
        position.incrementRow()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { return false }
            if stoneView.stoneType == stoneType { return true }
            position.incrementRow()
        }
        
        return false
    }
    
    private func reverseBottom(putPosition: DRStonePosition, stoneType: DRStoneType) {
        
        if self.calcReverseCountBottom(putPosition: putPosition, stoneType: stoneType) == 0 { return }
        
        var position = putPosition
        position.incrementRow()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { break }
            if stoneView.stoneType != stoneType.reverse() { break }
            stoneView.flipStone()
            position.incrementRow()
        }
    }
    
    private func calcReverseCountRightBottom(putPosition: DRStonePosition, stoneType: DRStoneType) -> Int {
        var position = putPosition
        position.incrementColumnRow()
        // 反転できる数
        var reverseCount = 0
        
        // 最初の１つ目をチェック
        let firstValue = self.stones.value(x: position.column, y: position.row)
        guard let firstStoneView = firstValue as? DRStoneView else { return 0 }
        if firstStoneView.stoneType == stoneType { return 0 }
        reverseCount += 1
        position.incrementColumnRow()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { return 0 }
            if stoneView.stoneType == stoneType { return reverseCount }
            reverseCount += 1
            position.incrementColumnRow()
        }
        
        return 0
    }
    
    private func canReverseRightBottom(putPosition: DRStonePosition, stoneType: DRStoneType) -> Bool {
        var position = putPosition
        position.incrementColumnRow()
        
        // 最初の１つ目をチェック
        let firstValue = self.stones.value(x: position.column, y: position.row)
        guard let firstStoneView = firstValue as? DRStoneView else { return false }
        if firstStoneView.stoneType == stoneType { return false }
        
        position.incrementColumnRow()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { return false }
            if stoneView.stoneType == stoneType { return true }
            position.incrementColumnRow()
        }
        
        return false
    }
    
    private func reverseRightBottom(putPosition: DRStonePosition, stoneType: DRStoneType) {
        
        if self.calcReverseCountRightBottom(putPosition: putPosition, stoneType: stoneType) == 0 { return }
        
        var position = putPosition
        position.incrementColumnRow()
        while(!position.isOutOfRange()) {
            let value = self.stones.value(x: position.column, y: position.row)
            guard let stoneView = value as? DRStoneView else { break }
            if stoneView.stoneType != stoneType.reverse() { break }
            stoneView.flipStone()
            position.incrementColumnRow()
        }
    }
}
