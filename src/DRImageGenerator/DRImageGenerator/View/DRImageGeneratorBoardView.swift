//
//  DRImageGeneratorBoardView.swift
//  DRImageGenerator
//
//  Created by DIO on 2020/04/05.
//  Copyright © 2020 DIO0550. All rights reserved.
//

import Cocoa

class DRImageGeneratorBoardView: NSView {
    
    // 背景色
    private static let BgColor: NSColor = .black
    // 盤面色
    private static let BoardColor: NSColor = .systemGreen
    // マージン
    private static let BoardMargin: CGFloat = 2.0
    // 線の太さ
    private static let BlockBorderWidth = 8.0
    private static let BlockCount = 2
    
    private var blockSize: CGFloat = 0
    private var boardRect: CGRect = CGRect.zero
    
    override public func updateConstraints() {
        super.updateConstraints()
        self.adjustBoardRect()
        self.updateStoneViewFrame()
    }
    
    
    private func adjustBoardRect() {
        // 小さい方のサイズ取得
        let smallerSize: CGFloat = min(self.bounds.height, self.bounds.width)
        let boardSize: CGFloat = smallerSize - ((DRImageGeneratorBoardView.BoardMargin) * 2)
        // 1つのブロックのサイズ
        self.blockSize = boardSize / CGFloat(DRImageGeneratorBoardView.BlockCount)
        let startPosX: CGFloat
        let startPosY: CGFloat
        if self.bounds.height > self.bounds.width {
            startPosX = DRImageGeneratorBoardView.BoardMargin
            startPosY = (self.bounds.height - (blockSize * CGFloat(DRImageGeneratorBoardView.BlockCount))) / 2.0
        } else {
            startPosX = (self.bounds.width - (blockSize * CGFloat(DRImageGeneratorBoardView.BlockCount))) / 2.0
            startPosY = DRImageGeneratorBoardView.BoardMargin
        }
        self.boardRect = CGRect(x: startPosX, y: startPosY, width: boardSize, height: boardSize)
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.drawBackground(rect)
        self.drawBoard(rect)
    }
    
    
    private func drawBackground(_ rect: CGRect) {
        DRImageGeneratorBoardView.BgColor.setFill()
        rect.fill()
    }
    
    private func drawBoardBgColor() {
        guard let context = NSGraphicsContext.current else { return }
        
        context.saveGraphicsState()
        let path = NSBezierPath.init(rect: self.boardRect)
        DRImageGeneratorBoardView.BoardColor.setFill()
        path.fill()
        context.restoreGraphicsState()
    }
    
    private func drawBoard(_ rect: CGRect) {
        
        self.drawBoardBgColor()
        
        guard let context = NSGraphicsContext.current else { return }
        context.saveGraphicsState()
        let path = NSBezierPath.init()
        for index in 0 ..< (DRImageGeneratorBoardView.BlockCount + 1) {
            let x: CGFloat = self.boardRect.origin.x + (CGFloat(index) * blockSize)
            var y: CGFloat = self.boardRect.origin.y
            path.move(to: CGPoint(x: x, y: y))
            y = self.boardRect.origin.y + (CGFloat(DRImageGeneratorBoardView.BlockCount) * blockSize)
            path.line(to: CGPoint(x: x, y: y))
        }
        
        for index in 0 ..< (DRImageGeneratorBoardView.BlockCount + 1) {
            var x: CGFloat = self.boardRect.origin.x
            let y: CGFloat = self.boardRect.origin.y + (CGFloat(index) * blockSize)
            path.move(to: CGPoint(x: x, y: y))
            x = self.boardRect.origin.x + (CGFloat(DRImageGeneratorBoardView.BlockCount) * blockSize)
            path.line(to: CGPoint(x: x, y: y))
        }
        path.lineWidth = CGFloat(DRImageGeneratorBoardView.BlockBorderWidth)
        path.stroke()
        
        let outerPath = NSBezierPath.init(rect: self.boardRect)
        outerPath.lineWidth = CGFloat(DRImageGeneratorBoardView.BlockBorderWidth) * 2.0
        outerPath.stroke()
        context.restoreGraphicsState()
    }
    
}

extension DRImageGeneratorBoardView {
    
    private func updateStoneViewFrame() {
//        for subView in self.subviews {
//            if (type(of: subView) !== DRImageGeneratorStoneView.self) {
//                continue
//            }
//
//            let stoneView = subView as! DRImageGeneratorStoneView
//
//            stoneView.frame = stoneRect
//        }
    }
}
