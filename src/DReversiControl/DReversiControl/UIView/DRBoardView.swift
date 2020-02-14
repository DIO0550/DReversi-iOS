//
//  DRBoardView.swift
//  DRevesiControl
//  リバーシ用の盤面
//  Created by DIO on 2019/12/18.
//  Copyright © 2019 DIO. All rights reserved.
//

import UIKit
import DReversiUtil

public protocol DRBoardViewDelegate: class {
    func boardView(_ boardView: DRBoardView, didSelectPosition position: DRStonePosition)
}

public class DRBoardView: UIView {
    // 背景色
    private static let BgColor: UIColor = .white
    // 盤面色
    private static let BoardColor: UIColor = .systemGreen
    // マージン
    private static let BoardMargin: CGFloat = 8.0
    // 線の太さ
    private static let BlockBorderWidth = 2.0
    
    private var blockSize: CGFloat = 0
    private var boardRect: CGRect = CGRect.zero
    
    // 選択中のポジション
    public private(set) var selectStonePosition: DRStonePosition = DRStonePosition(column: -1, row: -1) {
        didSet {
            self.delegate?.boardView(self, didSelectPosition: self.selectStonePosition)
        }
    }
    
    // デリゲート
    public weak var delegate: DRBoardViewDelegate?
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.adjustBoardRect()
    }
    
    
    private func adjustBoardRect() {
        // 小さい方のサイズ取得
        let smallerSize: CGFloat = min(self.bounds.height, self.bounds.width)
        let boardSize: CGFloat = smallerSize - ((DRBoardView.BoardMargin) * 2)
        // 1つのブロックのサイズ
        self.blockSize = boardSize / CGFloat(DReversiControlConst.BlockCount)
        let startPosX: CGFloat
        let startPosY: CGFloat
        if self.bounds.height > self.bounds.width {
            startPosX = DRBoardView.BoardMargin
            startPosY = (self.bounds.height - (blockSize * 8.0)) / 2.0
        } else {
            startPosX = (self.bounds.width - (blockSize * 8.0)) / 2.0
            startPosY = DRBoardView.BoardMargin
        }
        self.boardRect = CGRect(x: startPosX, y: startPosY, width: boardSize, height: boardSize)
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.drawBackground(rect)
        self.drawBoard(rect)
        self.drawSelectBorder()
    }
    

    private func drawBackground(_ rect: CGRect) {
        DRBoardView.BgColor.setFill()
        UIRectFill(rect)
    }
    
    private func drawBoardBgColor() {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.saveGState()
        let path = UIBezierPath.init(rect: self.boardRect)
        DRBoardView.BoardColor.setFill()
        path.fill()
        context.restoreGState()
    }
    
    private func drawBoard(_ rect: CGRect) {
        
        self.drawBoardBgColor()
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.saveGState()
        let path = UIBezierPath()
        for index in 0 ..< (DReversiControlConst.BlockCount + 1) {
            let x: CGFloat = self.boardRect.origin.x + (CGFloat(index) * blockSize)
            var y: CGFloat = self.boardRect.origin.y
            path.move(to: CGPoint(x: x, y: y))
            y = self.boardRect.origin.y + (CGFloat(DReversiControlConst.BlockCount) * blockSize)
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        for index in 0 ..< (DReversiControlConst.BlockCount + 1) {
            var x: CGFloat = self.boardRect.origin.x
            let y: CGFloat = self.boardRect.origin.y + (CGFloat(index) * blockSize)
            path.move(to: CGPoint(x: x, y: y))
            x = self.boardRect.origin.x + (CGFloat(DReversiControlConst.BlockCount) * blockSize)
            path.addLine(to: CGPoint(x: x, y: y))
        }
        path.lineWidth = CGFloat(DRBoardView.BlockBorderWidth)
        path.stroke()
        
        let outerPath = UIBezierPath.init(rect: self.boardRect)
        outerPath.lineWidth = CGFloat(DRBoardView.BlockBorderWidth) * 2.0
        outerPath.stroke()
        context.saveGState()
    }
    
    private func drawSelectBorder() {
        if self.selectStonePosition.isOutOfRange() { return }
        let rect = self.stonePositionRect(self.selectStonePosition)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.saveGState()
        let bezierPath = UIBezierPath(rect: rect)
        UIColor.systemYellow.setStroke()
        bezierPath.lineWidth = 2.0
        bezierPath.strokeInside()
        context.restoreGState()
    }
    
    public func stonePositionRect(_ stonePosition: DRStonePosition) -> CGRect {
        let x = self.boardRect.origin.x + self.blockSize * CGFloat(stonePosition.column)
        let y = self.boardRect.origin.y + self.blockSize * CGFloat(stonePosition.row)
        
        return CGRect(x: x, y: y, width: self.blockSize, height: self.blockSize)
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouche = touches.first else { return }
        let touchePoint = firstTouche.location(in: self)
        
        self.selectStonePosition = self.stonePositionFromPoint(touchePoint)
        self.setNeedsDisplay()
    }
    
}

extension DRBoardView {
    private func stonePositionFromPoint(_ point: CGPoint) -> DRStonePosition {
        for row in 0 ..< DReversiControlConst.BlockCount {
            for column in 0 ..< DReversiControlConst.BlockCount {
                let stonePosition = DRStonePosition(column: column, row: row)
                let rect = self.stonePositionRect(stonePosition)
                if rect.contains(point) {
                    return stonePosition
                }
                
            }
        }
        return DRStonePosition(column: -1, row: -1)
    }
}
