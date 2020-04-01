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
    
    // MARK: Public
    public var gameLevel: DReversiUtilConst.GameLevel = .NORMAL {
        didSet {
            switch self.gameLevel {
            case .EASY:
                self.gameAI = DRGameAIEasy()
            case .NORMAL:
                self.gameAI = DRGameAINormal()
            case .HARD:
                self.gameAI = DRGameAIHard()
            }
        }
    }
    public var playerStone: DRStoneType = .BLACK_STONE
    public var comStone: DRStoneType = .WHITE_STONE {
        didSet {
            // TODO: issues #2
            NSLog("change com stone")
        }
    }
    
    private var gameAI: DRGameAIBase = DRGameAIEasy()
    var gameTurn: DRGameTurn = .PLAYER {
        didSet {
            if self.gameTurn.isGameEnd() {
                self.updateResultMessage()
                self.gameResultView.isHidden = false
            }
            
            if self.gameTurn.isTurnPlayer() {
                let blackInfoColor = self.playerStone.isBlack() ? TURN_BACKGROUND_COLOR : NOT_TURN_BACKGROUND_COLOR
                let whiteInfoColor = self.playerStone.isBlack() ? NOT_TURN_BACKGROUND_COLOR : TURN_BACKGROUND_COLOR
                
                self.blackStoneInfoView.backgroundColor = blackInfoColor
                self.whiteStoneInfoView.backgroundColor = whiteInfoColor
            } else {
                let blackInfoColor = self.comStone.isBlack() ? TURN_BACKGROUND_COLOR : NOT_TURN_BACKGROUND_COLOR
                let whiteInfoColor = self.comStone.isBlack() ? NOT_TURN_BACKGROUND_COLOR : TURN_BACKGROUND_COLOR
                
                self.blackStoneInfoView.backgroundColor = blackInfoColor
                self.whiteStoneInfoView.backgroundColor = whiteInfoColor
            }
        }
    }
    
    // MARK INTERNAL
    internal var gameManager: DRGameManager = DRGameManager()
    internal let STONE_HOLDER_PLAYER = NSLocalizedString("DRGameStoneHolderPlayer", comment: "")
    internal let STONE_HOLDER_COM = NSLocalizedString("DRGameStoneHolderComputer", comment: "")
    
    // MARK CONSTANT
    private let TURN_BACKGROUND_COLOR = UIColor(named: "DRGameTurnBackgroundColor", in: Bundle.main, compatibleWith: nil)
    private let NOT_TURN_BACKGROUND_COLOR = UIColor(named: "DRGameNotTurnBackgroundColor", in: Bundle.main, compatibleWith: nil)
    
    // MARK: IBOutlet Instance
    @IBOutlet weak var boardView: DRBoardView!
    @IBOutlet weak var putStoneButton: UIButton!
    @IBOutlet weak var blackStoneCountLabel: UILabel!
    @IBOutlet weak var whiteStoneCountLabel: UILabel!
    @IBOutlet weak var settingMenuView: DRSettingMenuView!
    @IBOutlet weak var gameResultView: DRGameResultView!
    @IBOutlet weak var blackStoneInfoView: UIView!
    @IBOutlet weak var whiteStoneInfoView: UIView!
    @IBOutlet weak var blackStoneHolderLabel: UILabel!
    @IBOutlet weak var whiteStoneHolderLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupResultViewButtonsAction()
        self.boardView.delegate = self
        self.settingMenuView.setupSelectLevelButton(self.gameLevel)
        self.gameStart()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.removeNotifications()
    }
    
    func computerPutStoneLoop() {
        DispatchQueue.global().async {
            while true {
                if self.gameTurn.isGameEnd() { break }
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
    
    func updatePutStoneButtonEnable() {
        let isEnabled = self.gameManager.canPutReversePosition(stonePosition: self.boardView.selectStonePosition, stoneType: self.playerStone) && self.gameTurn.isTurnPlayer()
        self.putStoneButton.isEnabled = isEnabled
        self.putStoneButton.alpha = isEnabled ? 1.0 : 0.5
    }
    
    func updateStoneCountLabel() {
        self.blackStoneCountLabel.text = self.gameManager.stoneCount(stoneType: .BLACK_STONE).description
        self.whiteStoneCountLabel.text = self.gameManager.stoneCount(stoneType: .WHITE_STONE).description
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
        }
        
        if self.isGameEnd() {
            self.gameTurn = .GAME_END
        }
    }
    
    
    
    @IBAction func touchMenuButton(_ sender: Any) {
         self.settingMenuView.displayMenu()
    }
    
    @objc func backToTitle() {
        self.performSegue(withIdentifier: DRGameViewPopSegue.DRGameViewPopSegueSegueIdentifier, sender: self)
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
        }
        
        if self.isGameEnd() {
            self.gameTurn = .GAME_END
        }
    }
    
    
    @objc func selectLevelButton(aNotification: NSNotification?) {
        guard let notification = aNotification else { return }
        
        self.gameLevel = notification.userInfo![DReversiControlConst.SelectLevelButtonKey] as! DReversiUtilConst.GameLevel

    }
}

extension DRGameViewController: DRBoardViewDelegate {
    func boardView(_ boardView: DRBoardView, didSelectPosition position: DRStonePosition) {
        let isEnabled = self.gameManager.canPutReversePosition(stonePosition: position, stoneType: self.playerStone) && self.gameTurn.isTurnPlayer()
        self.putStoneButton.isEnabled = isEnabled
        self.putStoneButton.alpha = isEnabled ? 1.0 : 0.5
    }
}
