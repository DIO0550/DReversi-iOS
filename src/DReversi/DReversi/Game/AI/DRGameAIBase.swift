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
    // 石を置く場所
    func putStonePosition(stoneReverseInfos: [DRStoneReverseInfo]) -> DRStonePosition
    func maxReversePosition(stoneReverseInfos: [DRStoneReverseInfo]) -> DRStonePosition
    func notMaxReversePostion(stoneReverseInfos: [DRStoneReverseInfo]) -> DRStonePosition
}

extension DRGameAIBase {
    func maxReversePosition(stoneReverseInfos: [DRStoneReverseInfo]) -> DRStonePosition {
        guard let max = stoneReverseInfos.max() else {
            return DRStonePosition(column: -1, row: -1)
        }
        
        let maxInfos = stoneReverseInfos.filter {
            $0 == max
        }
        
        guard let maxInfo = maxInfos.randomElement() else {
            return DRStonePosition(column: -1, row: -1)
        }
        
        return maxInfo.stonePosition
    }
    
    func notMaxReversePostion(stoneReverseInfos: [DRStoneReverseInfo]) -> DRStonePosition {
        guard let max = stoneReverseInfos.max() else {
            return DRStonePosition(column: -1, row: -1)
        }
        
        let notMaxInfos = stoneReverseInfos.filter {
            $0 != max
        }
        
        if notMaxInfos.count > 0, let notMaxInfo = notMaxInfos.randomElement() {
            return notMaxInfo.stonePosition;
        }
        
        guard let stoneReverseInfo = stoneReverseInfos.randomElement() else {
            return DRStonePosition(column: -1, row: -1)
        }
        
        return stoneReverseInfo.stonePosition
    }
}
