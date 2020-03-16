//
//  DRTitleViewController.swift
//  DReversi
//  タイトル
//  Created by DIO on 2019/12/13.
//  Copyright © 2019 DIO. All rights reserved.
//

import UIKit
import DReversiUtil

class DRTitleViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    
    @IBOutlet weak var stoneLabel: UILabel!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    
    var isAnimating: Bool = false
    public var gameLevel: DReversiUtilConst.GameLevel = .NORMAL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTitle()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupTitle()
        self.adjustSecondControls()
    }
    
    @IBAction func touchLevelButton(_ sender: Any) {
        switch sender as! UIButton {
        case self.easyButton:
            self.gameLevel = .EASY
        case self.normalButton:
            self.gameLevel = .NORMAL
        case self.hardButton:
            self.gameLevel = .HARD
        default:
            self.gameLevel = .NORMAL
        }
        
        self.levelControlFadeOutAnimation()
    }
    @IBAction func touchBackButton(_ sender: Any) {
        self.stoneControlFadeOutAnimation()
    }
    
    @IBAction func touchStoneButton(_ sender: Any) {
        self.performSegue(withIdentifier: "DRSegueGameView", sender: self)
    }
    
    @IBAction func unwindBackTitle(segue: UIStoryboardSegue) {
       
    }
}

extension DRTitleViewController {
    
    private func setupTitle() {
        let blackShadow: NSShadow = DRTitleViewController.titleBlackShadow()
        let whiteShadow: NSShadow = DRTitleViewController.titleWhiteShadow()
        let fontSize = self.titleLabel.frame.size.width * DRConstants.DRTitleFontSizeRatio
        guard let length:Int = self.titleLabel.text?.count else { return }
        guard var attributes = self.titleLabel.attributedText?.attributes(at: 0, effectiveRange: nil) else { return }
        let font = UIFont.init(name: DRConstants.DRTitleFontName, size: fontSize)
        attributes[.font] = font
        
        
        
        let attributeTitleLabel: NSMutableAttributedString = NSMutableAttributedString()
        
        for i in 0 ..< length {
            let isEvenNumber: Bool = (i % 2) == 0
            let textColor: UIColor = isEvenNumber ? .black : .white
            let shadow: NSShadow = isEvenNumber ? whiteShadow : blackShadow
            attributes[.foregroundColor] = textColor
            attributes[.shadow] = shadow
            guard let char = self.titleLabel.text?.stringAtIndex(index: i) else { return }
            let attributeChar = NSAttributedString.init(string: char, attributes: attributes)
            attributeTitleLabel.append(attributeChar)
        }
        
        self.titleLabel.attributedText = attributeTitleLabel
    }
    
    
    /// レベル選択後のボタンを調整
    private func adjustSecondControls() {
        self.stoneLabel.center.x += self.view.frame.width * 3 / 4
        self.stoneLabel.alpha = 0
        
        self.blackButton.center.x += self.view.frame.width * 3 / 4
        self.blackButton.alpha = 0
        
        self.whiteButton.center.x += self.view.frame.width * 3 / 4
        self.whiteButton.alpha = 0
        
        self.backButton.center.x += self.view.frame.width * 3 / 4
        self.backButton.alpha = 0
    }
    
    static private func titleWhiteShadow() -> NSShadow {
        let whiteShadow: NSShadow = DRTitleViewController.titleShadow()
        whiteShadow.shadowColor = UIColor.white
        return whiteShadow
    }
    
    static private func titleBlackShadow() -> NSShadow {
        let blackShadow: NSShadow = DRTitleViewController.titleShadow()
        blackShadow.shadowColor = UIColor.black
        return blackShadow
    }
    
    static private func titleShadow() -> NSShadow {
        let shadow: NSShadow = NSShadow.init()
        shadow.shadowBlurRadius = DRConstants.DRTitleShadowBlurRadius
        shadow.shadowOffset = DRConstants.DRTitleShadowOffset
        return shadow
    }
    
}
