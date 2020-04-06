//
//  DRImageGeneratorCircleView.swift
//  DRImageGenerator
//
//  Created by DIO on 2020/04/05.
//  Copyright © 2020 DIO0550. All rights reserved.
//

import Cocoa

class DRImageGeneratorCircleView: NSView {

    override public var frame: CGRect {
        didSet {
            let radius: CGFloat = self.frame.width > self.frame.height ? self.frame.width / 2.0 : self.frame.height / 2.0
            self.layer?.cornerRadius = radius
        }
    }
    
    public init(frame: CGRect, color: NSColor) {
        super.init(frame: frame)
        self.wantsLayer = true
        let radius: CGFloat = frame.width > frame.height ? frame.width / 2.0 : frame.height / 2.0
        self.layer?.cornerRadius = radius
        self.layer?.backgroundColor = color.cgColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.wantsLayer = true
        let radius: CGFloat = frame.width > frame.height ? frame.width / 2.0 : frame.height / 2.0
        self.layer?.cornerRadius = radius
    }
}
