//
//  DRGameViewController.swift
//  DReversi
//  ゲーム画面
//  Created by DIO on 2019/12/13.
//  Copyright © 2019 DIO. All rights reserved.
//

import UIKit
import DReversiControl

class DRGameViewController: UIViewController {
    
    // MARK: Public Instance
    public var gameLevel: GameLevel = .NORMAL
    public var playerStone: DRStoneType = .BLACK_STONE
    
    // MARK: Private Instance
    private var gameManager: DRGameManager = DRGameManager()
    private var isInitializeStone: Bool = false
    
    // MARK: IBOutlet Instance
    @IBOutlet weak var boardView: DRBoardView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.initializeStones()
        }
    }
    @IBAction func touchPutButton(_ sender: Any) {
        let selectPosition = self.boardView.selectStonePosition
        
        self.gameManager.addStone(stonePosition: selectPosition,
                                  boardView: self.boardView,
                                  stoneType: self.playerStone)
        
        self.gameManager.reverseStone(putPosition: selectPosition, stoneType: self.playerStone)
    }
}

extension DRGameViewController {
    private func initializeStones() {
        if self.isInitializeStone { return }
        
        self.isInitializeStone = true;
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
}
