//
//  DHamburgerMenuButton.swift
//  DReversiControl
//
//  Created by DIO on 2020/01/11.
//  Copyright © 2020 DIO. All rights reserved.
//

import UIKit
import DReversiUtil

@IBDesignable
public class DHamburgerMenuButton: UIButton {
    
    @IBInspectable public var lineColor: UIColor = .black
    @IBInspectable public var lineWidth: CGFloat = 2.0
    
    override public var isHighlighted: Bool {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        self.drawStrokeLine(rect)
    }
    
    private func drawStrokeLine(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.saveGState()
        let color = self.isHighlighted ? self.lineColor.darkColor(0.5) : self.lineColor
        color.setStroke()
        
        let drawAreaHeight = rect.height * 2.0 / 3.0
        let drawAreaY = (rect.height - drawAreaHeight) / 2.0
        let drawArea = CGRect(x: rect.minX, y: drawAreaY, width: rect.width, height: drawAreaHeight)
        
        let bezeirPath = UIBezierPath()
        bezeirPath.lineWidth = self.lineWidth
        
        // 上の線を引く
        let topY = drawArea.minY + self.lineWidth / 2.0
        let topStartPoint = CGPoint(x: drawArea.minX, y: topY)
        let topEndPoint = CGPoint(x: drawArea.maxX, y: topY)
        
        bezeirPath.move(to: topStartPoint)
        bezeirPath.addLine(to: topEndPoint)
        
        // 真ん中の線を引く
        let centerStartPoint = CGPoint(x: drawArea.minX, y: drawArea.midY)
        let centerEndPoint = CGPoint(x: drawArea.maxX, y: drawArea.midY)
        
        bezeirPath.move(to: centerStartPoint)
        bezeirPath.addLine(to: centerEndPoint)
        
        // 下の線を引く
        let bottomY = drawArea.maxY - self.lineWidth / 2.0
        let bottomStartPoint = CGPoint(x: drawArea.minX, y: bottomY)
        let bottomEndPoint = CGPoint(x: drawArea.maxX, y: bottomY)
        
        bezeirPath.move(to: bottomStartPoint)
        bezeirPath.addLine(to: bottomEndPoint)
        
        bezeirPath.stroke()
        
        context.restoreGState()
    }

}
