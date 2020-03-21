//
//  UIView+Additional.swift
//  DReversiUtil
//
//  Created by DIO on 2020/03/21.
//  Copyright © 2020 DIO. All rights reserved.
//

import UIKit

extension UIView {
    public func removeAllSubviews() {
        for subview in self.subviews.reversed() {
            subview.removeFromSuperview()
        }
    }

}
