//
//  DRGameViewController+Result.swift
//  DReversi
//
//  Created by DIO on 2020/03/21.
//  Copyright © 2020 DIO. All rights reserved.
//

import UIKit

extension DRGameViewController {
    func updateResultMessage() {
        let palyerStoneCount = self.gameManager.stoneCount(stoneType: self.playerStone)
        let computerStoneCount = self.gameManager.stoneCount(stoneType: self.comStone)
        let result = self.gameResult(playerStoneCount: palyerStoneCount, computerStoneCount: computerStoneCount)
        self.gameResultView.gameResult = result
    }
    
    func gameResult(playerStoneCount: Int, computerStoneCount: Int) -> DRGameResult {
        if playerStoneCount == computerStoneCount { return .DRAW }
        if playerStoneCount > computerStoneCount  { return .PLAYER }
        if playerStoneCount < computerStoneCount  { return .COMPUTER }
        return .DRAW
    }
    
    func setupResultViewButtonsAction() {
        self.gameResultView.retryButton.addTarget(self, action: #selector(retryButtonAction(_:)), for: .touchUpInside)
        self.gameResultView.backTitleButton.addTarget(self, action: #selector(backTitleButtonAction(_:)), for: .touchUpInside)
    }
    
    @objc func backTitleButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "DRSegueGameView", sender: self)
    }
    
    @objc func retryButtonAction(_ sender: Any) {
        self.gameRestart()
    }
}
