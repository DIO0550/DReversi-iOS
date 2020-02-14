//
//  DReversiControlConst.swift
//  DReversiControl
//
//  Created by DIO on 2019/12/22.
//  Copyright © 2019 DIO. All rights reserved.
//

import UIKit

public struct DReversiControlConst {
    public static let BlockCount: Int = 8
    public static let BoardCornerPosition = [DRStonePosition(column: 0, row: 0), DRStonePosition(column: 7, row: 0),
                                             DRStonePosition(column: 0, row: 7), DRStonePosition(column: 7, row: 7)]
}
