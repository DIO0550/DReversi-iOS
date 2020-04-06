//
//  ViewController.swift
//  DRImageGenerator
//
//  Created by DIO on 2020/04/05.
//  Copyright © 2020 DIO0550. All rights reserved.
//

import Cocoa

class DRImageGeneratorViewController: NSViewController {
    @IBOutlet weak var imageGeneratorBoardView: DRImageGeneratorBoardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addStone(stonePosition: DRStonePosition(column: 1, row: 1),
                                  stoneType: .WHITE_STONE)
        self.addStone(stonePosition: DRStonePosition(column: 1, row: 2),
                                  stoneType: .BLACK_STONE)
        self.addStone(stonePosition: DRStonePosition(column: 2, row: 2),
                                  stoneType: .WHITE_STONE)
        self.addStone(stonePosition: DRStonePosition(column: 2, row: 1),
                                  stoneType: .BLACK_STONE)
    }
    
    func addStone(stonePosition: DRStonePosition, stoneType: DRStoneType) {
        
        let stoneRect: CGRect = self.imageGeneratorBoardView.stonePositionRect(stonePosition)
        let stoneView: DRImageGeneratorStoneView = DRImageGeneratorStoneView(frame: stoneRect, type: stoneType, stonePosition: stonePosition)
        
        self.imageGeneratorBoardView.addSubview(stoneView)
    }
    
}

