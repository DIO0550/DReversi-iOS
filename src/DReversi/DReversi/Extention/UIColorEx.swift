//
//  UIColorEx.swift
//  DReversi
//
//  Created by DIO on 2020/03/27.
//  Copyright © 2020 DIO. All rights reserved.
//

import UIKit

extension UIColor {
    static let DRGameResultPlayerWinMessageColor: UIColor = UIColor.init(named: "DRGameResultPlayerWinMessageColor", in: Bundle.main, compatibleWith: nil) ?? .systemRed
    
    static let DRGameResultComputerWinMessageColor: UIColor = UIColor.init(named: "DRGameResultComputerWinMessageColor", in: Bundle.main, compatibleWith: nil) ?? .systemBlue
    
    static let DRGameResultDrawMessageColor: UIColor = UIColor.init(named: "DRGameResultDrawMessageColor", in: Bundle.main, compatibleWith: nil) ?? .systemGreen
       
}
