//
//  DRGameAINormal.swift
//  DReversi
//
//  Created by DIO on 2019/12/19.
//  Copyright © 2019 DIO. All rights reserved.
//

import UIKit
import DReversiControl

class DRGameAINormal: DRGameAIBase {
    
    let isPriorityCorner: Bool
    
    init() {
        self.isPriorityCorner = false
    }
    
    func putStonePosition(stoneReverseInfos: [DRStoneReverseInfo]) -> DRStonePosition {
        return DRStonePosition(column: -1, row: -1)
    }
    

}
