//
//  DRGameViewPopSegue.swift
//  DReversi
//
//  Created by DIO on 2020/03/24.
//  Copyright © 2020 DIO. All rights reserved.
//

import UIKit

class DRGameViewPopSegue: UIStoryboardSegue {
    static let DRGameViewPopSegueSegueIdentifier = "DRGameViewPopSegue"
    
    override func perform() {
        UIView.transition(with: self.source.navigationController!.view, duration: 0.5, options: .transitionFlipFromTop, animations: {
            self.source.navigationController!.popViewController(animated: false)
        }) { finish in
            // do nothing
        }
    }
}
