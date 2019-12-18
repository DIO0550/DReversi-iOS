//
//  DRBoardView.swift
//  DRevesiControl
//  リバーシ用の盤面
//  Created by DIO on 2019/12/18.
//  Copyright © 2019 DIO. All rights reserved.
//

import UIKit

public class DRBoardView: UIView {
    // 背景色
    private static let BgColor: UIColor = .white
    // 盤面色
    private static let BoardColor: UIColor = .systemGreen
    // マージン
    private static let BoardMargin: CGFloat = 8.0
    // ブロック数
    private static let BlockNumber: Int = 8
    // 線の太さ
    private static let BlockBorderWidth = 2.0
    
    private var blockSize: CGFloat = 0
    private var boardRect: CGRect = CGRect.zero
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.adjustBoardRect()
    }
    
    private func adjustBoardRect() {
        // 小さい方のサイズ取得
        let smallerSize: CGFloat = min(self.bounds.height, self.bounds.width)
        let boardSize: CGFloat = smallerSize - ((DRBoardView.BoardMargin) * 2)
        // 1つのブロックのサイズ
        self.blockSize = boardSize / CGFloat(DRBoardView.BlockNumber)
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
        for index in 0 ..< (DRBoardView.BlockNumber + 1) {
            let x: CGFloat = self.boardRect.origin.x + (CGFloat(index) * blockSize)
            var y: CGFloat = self.boardRect.origin.y
            path.move(to: CGPoint(x: x, y: y))
            y = self.boardRect.origin.y + (CGFloat(DRBoardView.BlockNumber) * blockSize)
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        for index in 0 ..< (DRBoardView.BlockNumber + 1) {
            var x: CGFloat = self.boardRect.origin.x
            let y: CGFloat = self.boardRect.origin.y + (CGFloat(index) * blockSize)
            path.move(to: CGPoint(x: x, y: y))
            x = self.boardRect.origin.x  + (CGFloat(DRBoardView.BlockNumber) * blockSize)
            path.addLine(to: CGPoint(x: x, y: y))
        }
        path.lineWidth = CGFloat(DRBoardView.BlockBorderWidth)
        path.stroke()
        
        let outerPath = UIBezierPath.init(rect: self.boardRect)
        outerPath.lineWidth = CGFloat(DRBoardView.BlockBorderWidth) * 2.0
        outerPath.stroke()
        context.saveGState()
    }
    
    private func addStoneView(stonePos: DRStonePosition, stoneType: DRStoneType) {
        
    }
}
