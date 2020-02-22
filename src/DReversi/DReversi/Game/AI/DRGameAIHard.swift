//
//  DRGameAIHard.swift
//  DReversi
//
//  Created by DIO on 2019/12/19.
//  Copyright © 2019 DIO. All rights reserved.
//

import UIKit
import DReversiControl

class DRGameAIHard: DRGameAIBase {
    
    func putStonePosition(stoneReverseInfos: [DRStoneReverseInfo]) -> DRStonePosition {
        let cornerInfos = stoneReverseInfos.filter {
            DReversiControlConst.BoardCornerPosition.contains($0.stonePosition)
        }
        if cornerInfos.count > 0, let cornerInfo = cornerInfos.randomElement() {
            return cornerInfo.stonePosition
        }
        
        return self.maxReversePosition(stoneReverseInfos: stoneReverseInfos)
    }
    
    
}
