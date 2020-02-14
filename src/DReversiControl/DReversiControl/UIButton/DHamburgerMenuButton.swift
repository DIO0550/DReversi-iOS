//
//  DHamburgerMenuButton.swift
//  DReversiControl
//
//  Created by DIO on 2020/01/11.
//  Copyright © 2020 DIO. All rights reserved.
//

import UIKit

@IBDesignable
public class DHamburgerMenuButton: UIButton {
    
    @IBInspectable public var lineColor: UIColor = .black
    @IBInspectable public var lineWidth: CGFloat = 2.0
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        self.drawStrokeLine(rect)
    }
    
    private func drawStrokeLine(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.saveGState()
        self.lineColor.setStroke()
        
        let bezeirPath = UIBezierPath()
        bezeirPath.lineWidth = self.lineWidth
        
        // 上の線を引く
        let topY = rect.minY + self.lineWidth / 2.0
        let topStartPoint = CGPoint(x: rect.minX, y: topY)
        let topEndPoint = CGPoint(x: rect.maxX, y: topY)
        
        bezeirPath.move(to: topStartPoint)
        bezeirPath.addLine(to: topEndPoint)
        
        // 真ん中の線を引く
        let centerStartPoint = CGPoint(x: rect.minX, y: rect.midY)
        let centerEndPoint = CGPoint(x: rect.maxX, y: rect.midY)
        
        bezeirPath.move(to: centerStartPoint)
        bezeirPath.addLine(to: centerEndPoint)
        
        // 下の線を引く
        let bottomY = rect.maxY - self.lineWidth / 2.0
        let bottomStartPoint = CGPoint(x: rect.minX, y: bottomY)
        let bottomEndPoint = CGPoint(x: rect.maxX, y: bottomY)
        
        bezeirPath.move(to: bottomStartPoint)
        bezeirPath.addLine(to: bottomEndPoint)
        
        bezeirPath.stroke()
        
        context.restoreGState()
    }

}
