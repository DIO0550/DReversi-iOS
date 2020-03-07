//
//  DRMenuView.swift
//  DReversiControl
//
//  Created by DIO on 2020/02/29.
//  Copyright © 2020 DIO. All rights reserved.
//

import UIKit
import DReversiUtil

public class DRSettingMenuView: DRMenuView {
    
    @IBOutlet weak var easyLevelButton: DRSettingMenuLevelButton!
    @IBOutlet weak var normalLevelButton: DRSettingMenuLevelButton!
    @IBOutlet weak var hardLevelButton: DRSettingMenuLevelButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle.init(for: type(of: self)).loadNibNamed("DRSettingMenuView", owner: self, options: nil)
        let view: UIView? = bundle?.first as? UIView
        guard let topView: UIView = view else { return }
        topView.frame = CGRect(x: self.bounds.width - topView.bounds.width, y: 0, width: topView.bounds.width, height: self.bounds.height)
        self.addSubview(topView)
    }
    
    public func setupSelectLevelButton(_ selectLevel:DReversiUtilConst.GameLevel) {
        self.deselectedButtons()
        switch selectLevel {
        case .EASY:
            self.easyLevelButton.isSelected = true
            break
        case .NORMAL:
            self.normalLevelButton.isSelected = true
            break
        case .HARD:
            self.hardLevelButton.isSelected = true
            break
        }
    }
    
    private func deselectedButtons() {
        self.easyLevelButton.isSelected   = false
        self.normalLevelButton.isSelected = false
        self.hardLevelButton.isSelected   = false
    }
    
    private func selectLevel(_ sender: UIButton) -> DReversiUtilConst.GameLevel {
        if sender == self.easyLevelButton {
            return .EASY
        }
        
        if sender == self.normalLevelButton {
            return .NORMAL
        }
        
        if sender == self.hardLevelButton {
            return .HARD
        }
        
        return .NORMAL
    }
    
    @IBAction func touchLevelButton(_ sender: UIButton) {
        self.deselectedButtons()
        sender.isSelected = true
        let toucheLevel: DReversiUtilConst.GameLevel = self.selectLevel(sender);
        
        NotificationCenter.default.post(name: Notification.Name.DRSettingMenuViewSelectLevelNotifiactionName,
                                        object: sender,
                                        userInfo: [DReversiControlConst.SelectLevelButtonKey: toucheLevel])
    }
    
    @IBAction func touchBackButton(_ sender: Any) {
        self.hideMenu()
    }
}
