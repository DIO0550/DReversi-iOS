//
//  DRArray2D.swift
//  DReversi
//  二次元配列
//  Created by DIO on 2019/12/13.
//  Copyright © 2019 DIO. All rights reserved.
//

import UIKit
public class DRArray2D {
    /// 実際に使用する配列
    private var array: [[Any?]] = []
    private let width: Int;
    private let height: Int;
    
    /// 初期化メソッド
    /// - Parameters:
    ///   - width: 配列の幅
    ///   - height: 配列の高さ
    ///   - value: 初期化する値
    public init(width: Int, height: Int, value: Any?) {
        self.width = width
        self.height = height
        for _ in (0 ..< width) {
            self.array.append([Any?](repeating: value, count: height))
        }
    }
    
    public func value(x: Int, y: Int) -> Any? {
        if self.isOutOfBounds(x: x, y: y) { return nil }
        
        return self.array[x][y]
    }
    
    @discardableResult
    public func setValue(x: Int, y: Int, value: Any) -> Bool {
        if self.isOutOfBounds(x: x, y: y) { return false }
        
        self.array[x][y] = value
        return true
    }
    
    public func setAll(value: Any) {
        for x in 0 ..< self.width {
            for y in 0 ..< self.height {
                self.array[x][y] = value
            }
        }
    }
}


// MARK: Private Method
extension DRArray2D {
    private func isOutOfBounds(x: Int, y: Int) -> Bool {
        if x < 0 || self.width <= x { return true }
        if y < 0 || self.height <= y { return true }
        
        return false
    }
}
