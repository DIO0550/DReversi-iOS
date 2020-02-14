//
//  DRStoneReverseInfo.swift
//  DReversiControl
//
//  Created by DIO on 2020/01/11.
//  Copyright © 2020 DIO. All rights reserved.
//

import UIKit

public struct DRStoneReverseInfo {
    public var stonePosition: DRStonePosition
    public var reverseCount: Int
    
    public init(stonePosition: DRStonePosition, reverseCount: Int) {
        self.stonePosition = stonePosition;
        self.reverseCount = reverseCount
    }
}
