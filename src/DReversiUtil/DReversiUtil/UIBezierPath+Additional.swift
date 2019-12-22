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
        self.lineWidth = self.lineWidth * 2
        self.stroke()
        context.restoreGState()
    }
}
