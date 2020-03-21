//
//  UIBezierPath+Additional.swift
//  DReversiUtil
//
//  Created by DIO on 2019/12/22.
//  Copyright © 2019 DIO. All rights reserved.
//

import UIKit

extension UIBezierPath {
    public func strokeInside() {
        guard let context: CGContext = UIGraphicsGetCurrentContext() else { return }
        context.saveGState()
        self.addClip()
        let currentLineWidth = self.lineWidth
        self.lineWidth = self.lineWidth * 2
        self.stroke()
        self.lineWidth = currentLineWidth;
        context.restoreGState()
    }
}
