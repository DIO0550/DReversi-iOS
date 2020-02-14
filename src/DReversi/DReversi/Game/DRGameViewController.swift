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
    public var comStone: DRStoneType = .WHITE_STONE
    
    // MARK: Private Instance
    private var gameManager: DRGameManager = DRGameManager()
    private var isInitializeStone: Bool = false
    private var gameAI: DRGameAIBase = DRGameAIEasy()
    private var gameTurn: DRGameTurn = .PLAYER
    
    // MARK: IBOutlet Instance
    @IBOutlet weak var boardView: DRBoardView!
    @IBOutlet weak var putStoneButton: UIButton!
    @IBOutlet weak var blackStoneCountLabel: UILabel!
    @IBOutlet weak var whiteStoneCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.boardView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.initializeStones()
            weakSelf.computerPutStoneLoop()
        }
    }
    
    @IBAction func touchPutButton(_ sender: Any) {
        if !self.gameTurn.isTurnPlayer() { return }
        
        let selectPosition = self.boardView.selectStonePosition
        
        self.gameManager.addStone(stonePosition: selectPosition,
                                  boardView: self.boardView,
                                  stoneType: self.playerStone)
        
        self.gameManager.reverseStone(putPosition: selectPosition, stoneType: self.playerStone)
        self.updatePutStoneButtonEnable()
        
        if self.canPutComStone() {
            self.gameTurn = .COM
        }
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

    private func updatePutStoneButtonEnable() {
        let isEnabled = self.gameManager.canPutReversePosition(stonePosition: self.boardView.selectStonePosition, stoneType: self.playerStone) && self.gameTurn.isTurnPlayer()
        self.putStoneButton.isEnabled = isEnabled
        self.putStoneButton.alpha = isEnabled ? 1.0 : 0.5
    }
    
    private func canPutPlayerStone() -> Bool {
        return self.gameManager.canPutStonePositions(stoneType: self.playerStone).count > 0
    }
    
    private func canPutComStone() -> Bool {
        return self.gameManager.canPutStonePositions(stoneType: self.comStone).count > 0
    }
    
    private func comPutStone() {
        if !self.canPutPlayerStone() { return }
        let stoneReverseInfos = self.gameManager.stoneReverseInfos(stoneType: self.comStone)
        let aiPutPosition = self.gameAI.putStonePosition(stoneReverseInfos: stoneReverseInfos)
        self.gameManager.addStone(stonePosition: aiPutPosition,
                                  boardView: self.boardView,
                                  stoneType: self.comStone)
        self.gameManager.reverseStone(putPosition: aiPutPosition, stoneType: self.comStone)
        if self.canPutPlayerStone() {
            self.gameTurn = .PLAYER
        }
        self.updatePutStoneButtonEnable()
    }
    
    private func computerPutStoneLoop() {
        DispatchQueue.global().async {
            while true {
                if self.gameTurn.isTurnPlayer() { continue }
                Thread.sleep(forTimeInterval: 2.0)
                let semaphore = DispatchSemaphore(value: 0)
                DispatchQueue.main.sync { [weak self] in
                    guard let weakSelf = self else {
                        semaphore.signal()
                        return
                    }
                    if weakSelf.gameTurn.isTurnPlayer() {
                        semaphore.signal()
                        return
                    }
                    weakSelf.comPutStone()
                    semaphore.signal()
                }
                semaphore.wait()
            }
        }
    }
}

extension DRGameViewController: DRBoardViewDelegate {
    func boardView(_ boardView: DRBoardView, didSelectPosition position: DRStonePosition) {
        let isEnabled = self.gameManager.canPutReversePosition(stonePosition: position, stoneType: self.playerStone) && self.gameTurn.isTurnPlayer()
        self.putStoneButton.isEnabled = isEnabled
        self.putStoneButton.alpha = isEnabled ? 1.0 : 0.5
    }
}
