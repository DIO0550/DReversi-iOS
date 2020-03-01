//
//  DRSettingMenuLevelButton.swift
//  DReversiControl
//
//  Created by DIO on 2020/03/01.
//  Copyright © 2020 DIO. All rights reserved.
//

import UIKit

@IBDesignable
class DRSettingMenuLevelButton: UIButton {
    @IBInspectable var borderWidth: CGFloat = 0;
    @IBInspectable var borderColor: UIColor = .clear
    @IBInspectable var selectedBackgroundColor: UIColor = .clear
    @IBInspectable var deselectedBackgroundColor: UIColor = .clear
    @IBInspectable var selectedTextColor: UIColor = .clear {
        didSet {
            self.setTitleColor(self.selectedTextColor, for: .selected)
        }
    }
    @IBInspectable var deselectedTextColor: UIColor = .clear {
        didSet {
            self.setTitleColor(self.deselectedTextColor, for: .normal)
        }
    }
    
    override func draw(_ rect: CGRect) {
        self.layer.borderWidth = self.borderWidth;
        self.layer.borderColor = self.borderColor.cgColor
    }
    
    override var isSelected: Bool {
        willSet {
            if newValue {
                self.backgroundColor = self.selectedBackgroundColor
            } else {
                self.backgroundColor = self.deselectedBackgroundColor
            }
        }
    }
}
