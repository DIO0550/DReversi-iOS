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
    
    func putStonePosition(stoneReverseInfos: [DRStoneReverseInfo]) -> DRStonePosition {
        let random = Int.random(in: 0..<2)
        if random % 2 == 0 {
            return self.maxReversePosition(stoneReverseInfos: stoneReverseInfos)
        }
        
        return self.notMaxReversePostion(stoneReverseInfos: stoneReverseInfos)
    }
    

}
