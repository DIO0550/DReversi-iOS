//
//  DRMenuView.swift
//  DReversiControl
//
//  Created by DIO on 2020/02/29.
//  Copyright © 2020 DIO. All rights reserved.
//

import UIKit

public class DRSettingMenuView: DRMenuView {

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

}
