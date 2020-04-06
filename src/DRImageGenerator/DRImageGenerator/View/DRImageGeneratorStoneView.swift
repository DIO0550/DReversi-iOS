//
//  DRImageGeneratorStoneView.swift
//  DRImageGenerator
//
//  Created by DIO on 2020/04/05.
//  Copyright © 2020 DIO0550. All rights reserved.
//

import Cocoa

public enum DRStoneType {
    case BLACK_STONE
    case WHITE_STONE
    
    public func reverse() -> DRStoneType {
        switch self {
        case .BLACK_STONE:
            return .WHITE_STONE
        case .WHITE_STONE:
            return .BLACK_STONE
        }
    }
    
    public func isBlack() -> Bool {
        return self == .BLACK_STONE
    }
}

class DRImageGeneratorStoneView: NSView {
    
    public var stoneType: DRStoneType = .BLACK_STONE;
    public var blackStoneView: DRImageGeneratorCircleView!
    public var whiteStoneView: DRImageGeneratorCircleView!
    private let stoneMargin: CGFloat = 4.0
    public private(set) var stonePosition: DRStonePosition?
    
    override public var frame: CGRect {
        didSet {
            let size = self.frame.width > self.frame.height ? self.frame.height : self.frame.width
            if (self.blackStoneView != nil) {
                self.blackStoneView.frame.size = CGSize(width: size - self.stoneMargin * 2, height: size - self.stoneMargin * 2)
                self.blackStoneView.setFrameOrigin(CGPoint(x: self.stoneMargin, y: self.stoneMargin))
            }
            if (self.whiteStoneView != nil) {
                self.whiteStoneView.frame.size = CGSize(width: size - self.stoneMargin * 2, height: size - self.stoneMargin * 2)
                self.whiteStoneView.setFrameOrigin(CGPoint(x: self.stoneMargin, y: self.stoneMargin))
            }
        }
    }
    
    public init(frame: CGRect, type: DRStoneType, stonePosition: DRStonePosition) {
        super.init(frame: frame)
        let size = frame.width > frame.height ? frame.height : frame.width
        self.blackStoneView = DRImageGeneratorCircleView.init(frame: CGRect(x: self.stoneMargin,
                                                                            y: self.stoneMargin,
                                                                            width: size - self.stoneMargin * 2,
                                                                            height: size - self.stoneMargin * 2),  color: .black)
        
        self.whiteStoneView = DRImageGeneratorCircleView.init(frame: CGRect(x: self.stoneMargin,
                                                                            y: self.stoneMargin,
                                                                            width: size - self.stoneMargin * 2,
                                                                            height: size - self.stoneMargin * 2),  color: .white)
        
        
        
        self.stoneType = type
        self.stonePosition = stonePosition
        if self.stoneType.isBlack() {
            self.addSubview(self.blackStoneView)
        } else {
            self.addSubview(self.whiteStoneView)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
