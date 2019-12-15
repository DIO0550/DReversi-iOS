//
//  DRStoneView.swift
//  DReversi
//
//  Created by DIO on 2019/12/15.
//  Copyright © 2019 DIO. All rights reserved.
//

import UIKit

public enum StoneType {
    case BLACK_STONE
    case WHITE_STONE
    
    func reverse() -> StoneType {
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
    public var stoneType: StoneType = .BLACK_STONE;
    public var blackStoneView: DRStoneCircleView!
    public var whiteStoneView: DRStoneCircleView!
    
    public init(frame: CGRect, type: StoneType) {
        super.init(frame: frame)
        let size = frame.width > frame.height ? frame.height : frame.width
        self.blackStoneView = DRStoneCircleView.init(frame: CGRect(x: 0, y: 0, width: size, height: size),  color: .black)
        self.blackStoneView.center = self.center
        self.whiteStoneView = DRStoneCircleView.init(frame: CGRect(x: 0, y: 0, width: size, height: size),  color: .white)
        self.whiteStoneView.center = self.center
        self.stoneType = type
        
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
