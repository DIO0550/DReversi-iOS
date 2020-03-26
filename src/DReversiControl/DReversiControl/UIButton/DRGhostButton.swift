//
//  DRGhostButton.swift
//  DReversiControl
//
//  Created by DIO on 2020/03/26.
//  Copyright © 2020 DIO. All rights reserved.
//

import UIKit

@IBDesignable
public class DRGhostButton: UIButton {
    @IBInspectable var color: UIColor = .clear {
        didSet {
            self.setTitleColor(self.color, for: .normal)
            self.layer.borderColor = self.color.cgColor
        }
    }
    
    override public var isHighlighted: Bool {
        didSet {
            self.backgroundColor = self.isHighlighted ? self.color : .clear
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    
    
    private func commonInit() {
        self.setTitleColor(self.color, for: .normal)
        self.setTitleColor(.white, for: .highlighted)
        self.backgroundColor = self.color
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1.0
    }
    
}
