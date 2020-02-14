//
//  DRGameTurn.swift
//  DReversi
//
//  Created by DIO on 2020/02/14.
//  Copyright © 2020 DIO. All rights reserved.
//

import UIKit

enum DRGameTurn {
    case PLAYER
    case COM
    
    func isTurnPlayer() -> Bool {
        return self == .PLAYER
    }
}
