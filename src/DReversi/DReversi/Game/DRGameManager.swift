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
    
    public func canPutStoneBlack() -> [DRStonePosition] {
        // TODO: 仮で返しているので、実際の使用する処理に修正する
        return [DRStonePosition(column: -1, row: -1)]
    }
    
    public func canPutStoneWhite() -> [DRStonePosition] {
        // TODO: 仮で返しているので、実際の使用する処理に修正する
        return [DRStonePosition(column: -1, row: -1)]
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
        if !self.canPutPosition(stonePosition: stonePosition) { return false }
        
        let stoneRect: CGRect = boardView.stonePositionRect(stonePosition)
        let stoneView: DRStoneView = DRStoneView(frame: stoneRect, type: stoneType)
        
        let success: Bool = self.stones.setValue(x: stonePosition.column, y: stonePosition.row, value: stoneView)
        
        if !success { return false }
        
        boardView.addSubview(stoneView)
        
        return true
    }
    
    
}

extension DRGameManager {
    private func canPutPosition(stonePosition: DRStonePosition) -> Bool {
        if stonePosition.isOutOfRange() { return false }
        if self.stones.value(x: stonePosition.column, y: stonePosition.row) != nil { return false }
        return true
    }
    
    // MARK: reverse method
    
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
        
        if !self.canReverseLeftTop(putPosition: putPosition, stoneType: stoneType) { return }
        
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
        
        if !self.canReverseTop(putPosition: putPosition, stoneType: stoneType) { return }
        
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
        
        if !self.canReverseRightTop(putPosition: putPosition, stoneType: stoneType) { return }
        
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
        
        if !self.canReverseLeft(putPosition: putPosition, stoneType: stoneType) { return }
        
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
        
        if !self.canReverseRight(putPosition: putPosition, stoneType: stoneType) { return }
        
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
        
        if !self.canReverseLeftBottom(putPosition: putPosition, stoneType: stoneType) { return }
        
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
        
        if !self.canReverseBottom(putPosition: putPosition, stoneType: stoneType) { return }
        
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
        
        if !self.canReverseRightBottom(putPosition: putPosition, stoneType: stoneType) { return }
        
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
