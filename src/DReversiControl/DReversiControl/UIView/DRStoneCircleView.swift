//
//  DRStoneCircleView.swift
//  DReversi
//
//  Created by DIO on 2019/12/15.
//  Copyright © 2019 DIO. All rights reserved.
//

import UIKit


public class DRStoneCircleView: UIView {
    override public var frame: CGRect {
        didSet {
            let radius: CGFloat = self.frame.width > self.frame.height ? self.frame.width / 2.0 : self.frame.height / 2.0
            self.layer.cornerRadius = radius
        }
    }
    
    public init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        let radius: CGFloat = frame.width > frame.height ? frame.width / 2.0 : frame.height / 2.0
        self.layer.cornerRadius = radius
        self.backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let radius: CGFloat = frame.width > frame.height ? frame.width / 2.0 : frame.height / 2.0
        self.layer.cornerRadius = radius
    }
}
