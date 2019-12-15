//
//  DRStoneCircleView.swift
//  DReversi
//
//  Created by DIO on 2019/12/15.
//  Copyright © 2019 DIO. All rights reserved.
//

import UIKit


public class DRStoneCircleView: UIView {
    public init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        let radius: CGFloat = frame.width > frame.height ? frame.width / 2.0 : frame.height / 2.0
        self.layer.cornerRadius = radius
        self.backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("please call init(frame: CGRect, color: UIColor)")
    }
}
