//
//  DRGameResult.swift
//  DReversi
//
//  Created by DIO on 2020/03/27.
//  Copyright © 2020 DIO. All rights reserved.
//

import UIKit

enum DRGameResult {
    case PLAYER
    case COMPUTER
    case DRAW
    
    func gameResultText() -> String {
        switch self {
        case .PLAYER:
            return NSLocalizedString("DRGameResultPlayerWin", comment: "")
        case .COMPUTER:
            return NSLocalizedString("DRGameResultComputerWin", comment: "")
        case .DRAW:
            return NSLocalizedString("DRGameResultDraw", comment: "")
        }
    }
    
    func gemeResultTextColor() -> UIColor {
        switch self {
        case .PLAYER:
            return .DRGameResultPlayerWinMessageColor
        case .COMPUTER:
            return .DRGameResultComputerWinMessageColor
        case .DRAW:
            return .DRGameResultDrawMessageColor
        }
    }
}
