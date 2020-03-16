//
//  DRGameViewController.swift
//  DReversi
//  ゲーム画面
//  Created by DIO on 2019/12/13.
//  Copyright © 2019 DIO. All rights reserved.
//

import UIKit
import DReversiControl
import DReversiUtil

class DRGameViewController: UIViewController {
    
    // MARK: Public Instance
    public var gameLevel: DReversiUtilConst.GameLevel = .NORMAL
    public var playerStone: DRStoneType = .BLACK_STONE
    public var comStone: DRStoneType = .WHITE_STONE {
        didSet {
            // TODO: issues #2
            NSLog("change com stone")
        }
    }
    
    // MARK: Private Instance
    private var gameManager: DRGameManager = DRGameManager()
    private var isInitializeStone: Bool = false
    private var gameAI: DRGameAIBase = DRGameAIEasy()
    private var gameTurn: DRGameTurn = .PLAYER {
        didSet {
            if self.gameTurn.isGameEnd() {
                self.gameResultView.isHidden = false
            }
        }
    }
    private let PLAYER_TURN_LABEL = NSLocalizedString("DRGameTurnPlayer", comment: "")
    private let COMPUTER_TURN_LABEL = NSLocalizedString("DRGameTurnComputer", comment: "")
    
    // MARK: IBOutlet Instance
    @IBOutlet weak var boardView: DRBoardView!
    @IBOutlet weak var putStoneButton: UIButton!
    @IBOutlet weak var blackStoneCountLabel: UILabel!
    @IBOutlet weak var whiteStoneCountLabel: UILabel!
    @IBOutlet weak var settingMenuView: DRSettingMenuView!
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var gameResultView: DRGameResultView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gameResultView.isHidden = true
        self.boardView.delegate = self
        self.settingMenuView.setupSelectLevelButton(self.gameLevel)
        self.initializeStones()
        self.settingMenuView.setupMenuPosition()
        self.computerPutStoneLoop()
        self.updateStoneCountLabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.removeNotifications()
    }
    
    @IBAction func touchPutButton(_ sender: Any) {
        if !self.gameTurn.isTurnPlayer() { return }
        
        let selectPosition = self.boardView.selectStonePosition
        
        self.gameManager.addStone(stonePosition: selectPosition,
                                  boardView: self.boardView,
                                  stoneType: self.playerStone)
        
        self.gameManager.reverseStone(putPosition: selectPosition, stoneType: self.playerStone)
        self.updatePutStoneButtonEnable()
        self.updateStoneCountLabel()
        
        if self.canPutComStone() {
            self.gameTurn = .COM
            self.turnLabel.text = COMPUTER_TURN_LABEL
        }
        
        if self.isGameEnd() {
            self.gameTurn = .GAME_END
        }
    }
    
    @IBAction func touchMenuButton(_ sender: Any) {
         self.settingMenuView.displayMenu()
    }
    
    @objc func backToTitle() {
        self.performSegue(withIdentifier: "DRSegueGameView", sender: self)
    }
}

extension DRGameViewController {
    
    private func addNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(selectLevelButton(aNotification:)),
                                               name:.DRSettingMenuViewSelectLevelNotifiactionName,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(backToTitle),
                                               name: .DRBackToTitleViewNotificationName,
                                               object: nil)
    }
    
    private func removeNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
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
    
    private func updateStoneCountLabel() {
        self.blackStoneCountLabel.text = self.gameManager.stoneCount(stoneType: .BLACK_STONE).description
        self.whiteStoneCountLabel.text = self.gameManager.stoneCount(stoneType: .WHITE_STONE).description
    }
    
    private func canPutPlayerStone() -> Bool {
        return self.gameManager.canPutStonePositions(stoneType: self.playerStone).count > 0
    }
    
    private func canPutComStone() -> Bool {
        return self.gameManager.canPutStonePositions(stoneType: self.comStone).count > 0
    }
    
    private func isGameEnd() -> Bool {
        return !self.canPutPlayerStone() && !self.canPutComStone()
    }
    
    private func comPutStone() {
        if !self.canPutPlayerStone() { return }
        let stoneReverseInfos = self.gameManager.stoneReverseInfos(stoneType: self.comStone)
        let aiPutPosition = self.gameAI.putStonePosition(stoneReverseInfos: stoneReverseInfos)
        self.gameManager.addStone(stonePosition: aiPutPosition,
                                  boardView: self.boardView,
                                  stoneType: self.comStone)
        self.gameManager.reverseStone(putPosition: aiPutPosition, stoneType: self.comStone)
        
        self.updatePutStoneButtonEnable()
        self.updateStoneCountLabel()
        
        if self.canPutPlayerStone() {
            self.gameTurn = .PLAYER
            self.turnLabel.text = PLAYER_TURN_LABEL
        }
        
        if self.isGameEnd() {
            self.gameTurn = .GAME_END
        }
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
    
    @objc func selectLevelButton(aNotification: NSNotification?) {
        guard let notification = aNotification else { return }
        
        self.gameLevel = notification.userInfo![DReversiControlConst.SelectLevelButtonKey] as! DReversiUtilConst.GameLevel
        
        switch self.gameLevel {
        case .EASY:
            self.gameAI = DRGameAIEasy()
            break
        case .NORMAL:
            self.gameAI = DRGameAINormal()
            break
        case .HARD:
            self.gameAI = DRGameAIHard()
            break
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
