//
//  DRGameResultView.swift
//  DReversi
//
//  Created by DIO on 2020/03/14.
//  Copyright © 2020 DIO. All rights reserved.
//

import UIKit

class DRGameResultView: UIView {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var backTitleButton: UIButton!
    @IBOutlet weak var retryButton: UIButton!
    
    var gameResult: DRGameResult = .DRAW {
        didSet {
            self.updateMessage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = .clear
        let nib = UINib.init(nibName: String(describing: type(of: self)), bundle: Bundle.main)
        let subView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        subView.frame = CGRect(origin: CGPoint.zero, size: self.frame.size)
        self.addSubview(subView)
        
        let views = ["subView": subView]
        
        let vVisualFormat = "V:|-0-[subView]-0-|"
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: vVisualFormat, options:.alignAllTop, metrics: nil, views: views)
        
        let hVisualFormat = "H:|-0-[subView]-0-|"
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: hVisualFormat, options:.alignAllTop, metrics: nil, views: views)
        
        self.addConstraints(vConstraints)
        self.addConstraints(hConstraints)
    }
    
    private func updateMessage() {
        let attributedMessage: NSMutableAttributedString = NSMutableAttributedString.init(string: self.gameResult.gameResultText())
        let font: UIFont = self.messageLabel.font
        let color: UIColor = self.gameResult.gemeResultTextColor()
        let attributes: [NSAttributedString.Key : Any] = [.font: font, .foregroundColor: color, .kern : 20.0];
        attributedMessage.setAttributes(attributes, range: NSRange(location: 0, length: attributedMessage.length))
        
        self.messageLabel.attributedText = attributedMessage
    }
}
