//
//  DRGameViewSegue.swift
//  DReversi
//
//  Created by DIO on 2019/12/16.
//  Copyright © 2019 DIO. All rights reserved.
//

import UIKit

class DRGameViewSegue: UIStoryboardSegue {
    override func perform() {
        let destVC = self.destination
        let sourceVC = self.source
        
        if destVC is DRGameViewController && sourceVC is DRTitleViewController {
            (destVC as! DRGameViewController).gameLevel = (sourceVC as! DRTitleViewController).gameLevel
            
            UIView.transition(with: sourceVC.navigationController!.view, duration: 0.5, options: .transitionFlipFromTop, animations: {
                sourceVC.navigationController!.pushViewController(destVC, animated: false)
            }) { finish in
                
            }
        } else {
            UIView.transition(with: sourceVC.navigationController!.view, duration: 0.5, options: .transitionFlipFromTop, animations: {
                sourceVC.navigationController!.popViewController(animated: false)
            }) { finish in
                
            }
        }
    }
}
