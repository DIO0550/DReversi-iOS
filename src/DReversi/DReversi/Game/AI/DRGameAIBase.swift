//
//  DRGameAIBase.swift
//  DReversi
//  AIのベース
//  Created by DIO on 2019/12/19.
//  Copyright © 2019 DIO. All rights reserved.
//

import UIKit
import DReversiControl

protocol DRGameAIBase {
    // 角を優先的に取るか
    var isPriorityCorner: Bool { get }
    // 石を置く場所
    func putStonePosition(stoneReverseInfos: [DRStoneReverseInfo]) -> DRStonePosition
}
