//
//  DRGameAIEasy.swift
//  DReversi
//
//  Created by DIO on 2019/12/19.
//  Copyright © 2019 DIO. All rights reserved.
//

import UIKit
import DReversiControl

class DRGameAIEasy: DRGameAIBase {
    let isPriorityCorner: Bool
    
    init() {
        self.isPriorityCorner = false
    }
    
    func putStonePosition(stoneReverseInfos: [DRStoneReverseInfo]) -> DRStonePosition {
        // TODO: 石を置く処理
        guard let stoneReverseInfo = stoneReverseInfos.randomElement() else {
            return DRStonePosition(column: -1, row: -1)
        }
        
        return stoneReverseInfo.stonePosition
    }
    

}
