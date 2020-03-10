//
//  DRMenuView.swift
//  DReversiControl
//
//  Created by DIO on 2020/02/29.
//  Copyright © 2020 DIO. All rights reserved.
//

import UIKit

public enum DRMenuPosition: Int {
    case Top
    case Right
    case Bottom
    case Left
    
    static func isNotExistPosition(position: DRMenuPosition) -> Bool {
        if position.rawValue < DRMenuPosition.Top.rawValue || DRMenuPosition.Left.rawValue < position.rawValue {
            return true
        }
        return false
    }
}


public class DRMenuView: UIView {
    
    public var animationDuration = 1.0
    
    public var menuPosition: DRMenuPosition = .Top
    
    @IBInspectable public var MenuPosition: Int {
        get {
            return self.menuPosition.rawValue
        }
        set {
            self.menuPosition = DRMenuPosition(rawValue: newValue)!
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViewSize()
        self.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupViewSize()
        self.backgroundColor = .clear
    }
    
    private func setupViewSize() {
        guard let window: UIWindow = UIApplication.shared.windows.first ?? nil else {
            return;
        }
        
        let windowBounds: CGRect = window.bounds
        self.bounds.size = windowBounds.size
    }
    
    public func setupMenuPosition() {
        guard let window: UIWindow = UIApplication.shared.windows.first ?? nil else {
            return;
        }
        
        let windowBounds: CGRect = window.bounds
        switch self.menuPosition {
        case .Top:
            self.frame.origin = CGPoint(x: 0, y: -self.bounds.height)
            break
        case .Right:
            self.frame.origin = CGPoint(x: windowBounds.width, y: 0)
            break
        case .Bottom:
            self.frame.origin = CGPoint(x: 0, y: windowBounds.height)
            break
        case .Left:
            self.frame.origin = CGPoint(x: self.bounds.width, y: 0)
            break
        }
        
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (event?.touches(for: self)) != nil {
            self.hideMenu()
        }
    }
    
    public func displayMenu() {
        UIView.animate(withDuration: self.animationDuration) {
            self.frame.origin = CGPoint(x: 0, y: 0)
        }
    }
    
    public func hideMenu() {
        guard let window: UIWindow = UIApplication.shared.windows.first ?? nil else {
            return;
        }
        let windowBounds: CGRect = window.bounds
        var animationPoint: CGPoint;
        switch self.menuPosition {
        case .Top:
            animationPoint = CGPoint(x: 0, y: -self.bounds.height)
            break
        case .Right:
            animationPoint = CGPoint(x: windowBounds.width, y: 0)
            break
        case .Bottom:
            animationPoint = CGPoint(x: 0, y: windowBounds.height)
            break
        case .Left:
            animationPoint = CGPoint(x: self.bounds.width, y: 0)
            break
        }
        
        UIView.animate(withDuration: self.animationDuration) {
            self.frame.origin = animationPoint
        }
    }
}
