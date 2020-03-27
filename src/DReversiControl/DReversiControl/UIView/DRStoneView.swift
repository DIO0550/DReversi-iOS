//
//  DRStoneView.swift
//  DReversi
//
//  Created by DIO on 2019/12/15.
//  Copyright © 2019 DIO. All rights reserved.
//

import UIKit

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
    
    func isBlack() -> Bool {
        return self == .BLACK_STONE
    }
}
public class DRStoneView: UIView {
    public var stoneType: DRStoneType = .BLACK_STONE;
    public var blackStoneView: DRStoneCircleView!
    public var whiteStoneView: DRStoneCircleView!
    private let stoneMargin: CGFloat = 4.0
    public private(set) var stonePosition: DRStonePosition?
    
    override public var frame: CGRect {
        didSet {
            let size = self.frame.width > self.frame.height ? self.frame.height : self.frame.width
            if (self.blackStoneView != nil) {
                self.blackStoneView.frame.size = CGSize(width: size - self.stoneMargin * 2, height: size - self.stoneMargin * 2)
                self.blackStoneView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
            }
            if (self.whiteStoneView != nil) {
                self.whiteStoneView.frame.size = CGSize(width: size - self.stoneMargin * 2, height: size - self.stoneMargin * 2)
                self.whiteStoneView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
            }
        }
    }
    
    public init(frame: CGRect, type: DRStoneType, stonePosition: DRStonePosition) {
        super.init(frame: frame)
        let size = frame.width > frame.height ? frame.height : frame.width
        self.blackStoneView = DRStoneCircleView.init(frame: CGRect(x: self.stoneMargin, y: self.stoneMargin, width: size - self.stoneMargin * 2, height: size - self.stoneMargin * 2),  color: .black)
        self.blackStoneView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        self.whiteStoneView = DRStoneCircleView.init(frame: CGRect(x: self.stoneMargin, y: self.stoneMargin, width: size - self.stoneMargin * 2, height: size - self.stoneMargin * 2),  color: .white)
        self.whiteStoneView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
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
    
    public func flipStone() {
        let toView = self.stoneType.isBlack() ? self.whiteStoneView : self.blackStoneView
        let fromView = self.stoneType.isBlack() ? self.blackStoneView : self.whiteStoneView
        UIView.transition(from: fromView!, to: toView!, duration: 1, options: .transitionFlipFromTop, completion: nil)
        toView!.translatesAutoresizingMaskIntoConstraints = false
     
        self.stoneType = self.stoneType.reverse()
    }
}
