//
//  DRGameViewController.swift
//  DReversi
//  ゲーム画面
//  Created by DIO on 2019/12/13.
//  Copyright © 2019 DIO. All rights reserved.
//

import UIKit
import DRevesiControl

class DRGameViewController: UIViewController {
    public var gameLevel: GameLevel = .NORMAL

    @IBOutlet weak var boardView: DRBoardView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
