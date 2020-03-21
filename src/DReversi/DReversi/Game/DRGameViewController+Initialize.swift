//
//  DRGameViewController+Initialize.swift
//  DReversi
//
//  Created by DIO on 2020/03/21.
//  Copyright © 2020 DIO. All rights reserved.
//

import UIKit
import DReversiControl
import DReversiUtil

extension DRGameViewController {
    func gameRestart() {
        self.boardView.removeAllSubviews()
        self.gameManager.reset()
        self.gameStart()
    }
    
    func gameStart() {
        self.gameResultView.isHidden = true
        self.initializeGameTurn()
        self.initializeStones()
        self.computerPutStoneLoop()
        self.settingMenuView.setupMenuPosition()
        self.computerPutStoneLoop()
        self.updatePutStoneButtonEnable()
        self.updateStoneCountLabel()
    }
    
    func initializeStones() {
        self.gameManager.addStone(stonePosition: DRStonePosition(column: 3, row: 3),
                                  boardView: self.boardView,
                                  stoneType: .WHITE_STONE)
        self.gameManager.addStone(stonePosition: DRStonePosition(column: 4, row: 3),
                                  boardView: self.boardView,
                                  stoneType: .BLACK_STONE)
        self.gameManager.addStone(stonePosition: DRStonePosition(column: 4, row: 4),
                                  boardView: self.boardView,
                                  stoneType: .WHITE_STONE)
        self.gameManager.addStone(stonePosition: DRStonePosition(column: 3, row: 4),
                                  boardView: self.boardView,
                                  stoneType: .BLACK_STONE)
        
    }
    
    func initializeGameTurn() {
        self.gameTurn = (self.playerStone == .BLACK_STONE) ? .PLAYER : .COM
    }
}
