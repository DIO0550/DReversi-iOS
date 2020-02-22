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
    
    func putStonePosition(stoneReverseInfos: [DRStoneReverseInfo]) -> DRStonePosition {
        return notMaxReversePostion(stoneReverseInfos: stoneReverseInfos)
    }
    
}
