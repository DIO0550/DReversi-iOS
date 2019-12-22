//
//  DRGameAIBase.swift
//  DReversi
//  AIのベース
//  Created by DIO on 2019/12/19.
//  Copyright © 2019 DIO. All rights reserved.
//

import UIKit

protocol DRGameAIBase {
    var isPriorityCorner: Bool { get }
    func putStone()
}
