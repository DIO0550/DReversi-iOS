//
//  UIColorEx.swift
//  DReversiUtil
//
//  Created by DIO on 2020/04/01.
//  Copyright © 2020 DIO. All rights reserved.
//

import UIKit

extension UIColor {
    public func darkColor(_ brightnessRatio: CGFloat) -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor.init(hue: hue, saturation: saturation, brightness: brightness * brightness, alpha: alpha)
        }
        // failed
        return self;
    }
}
