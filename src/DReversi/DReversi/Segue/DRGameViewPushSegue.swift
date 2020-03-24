//
//  DRGameViewPushSegue.swift
//  DReversi
//
//  Created by DIO on 2020/03/24.
//  Copyright © 2020 DIO. All rights reserved.
//

import UIKit

// PushSegue
class DRGameViewPushSegue: UIStoryboardSegue {
    static let DRGameViewPushSegueIdentifier = "DRGameViewPushSegue"
    
    override func perform() {
        UIView.transition(with: self.source.navigationController!.view, duration: 0.5, options: .transitionFlipFromTop, animations: {
            self.source.navigationController!.pushViewController(self.destination, animated: false)
        }) { finish in
            // back button action
            guard let titileVC = self.source as? DRTitleViewController ?? nil else {
                return
            }
            titileVC.touchBackButton(titileVC.backButton!)
        }
    }
}
