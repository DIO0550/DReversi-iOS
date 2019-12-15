//
//  DRTitleViewController+Animation.swift
//  DReversi
//
//  Created by DIO on 2019/12/14.
//  Copyright © 2019 DIO. All rights reserved.
//

import UIKit

extension DRTitleViewController {
    
    func levelControlFadeOutAnimation() {
        
        if self.isAnimating { return }
        
        self.isAnimating = true
        UIView.animateKeyframes(withDuration: DRConstants.DRTitleAnimationeDuration, delay: 0.0, options: [], animations: {

            UIView.addKeyframe(withRelativeStartTime: DRConstants.DRTitleAnimationFirstRelativeStartTime, relativeDuration: DRConstants.DRTitleAnimationRelativeDuration, animations: {
                self.levelLabel.center.x += self.view.frame.width * 3 / 4
                self.levelLabel.alpha = 0
            })

            UIView.addKeyframe(withRelativeStartTime: DRConstants.DRTitleAnimationSecondRelativeStartTime, relativeDuration: DRConstants.DRTitleAnimationRelativeDuration, animations: {
                self.easyButton.center.x += self.view.frame.width * 3 / 4
                self.easyButton.alpha = 0
            })

            UIView.addKeyframe(withRelativeStartTime: DRConstants.DRTitleAnimationThirdRelativeStartTime, relativeDuration: DRConstants.DRTitleAnimationRelativeDuration, animations: {
                self.normalButton.center.x += self.view.frame.width * 3 / 4
                self.normalButton.alpha = 0
            })

            UIView.addKeyframe(withRelativeStartTime: DRConstants.DRTitleAnimationFourthRelativeStartTime, relativeDuration: DRConstants.DRTitleAnimationRelativeDuration, animations: {
                self.hardButton.center.x += self.view.frame.width * 3 / 4
                self.hardButton.alpha = 0
            })
            
        }) { _ in
            self.stoneControlFadeInAnimation()
        }
    }
    
    private func levelControlFadeInAnimation() {
        UIView.animateKeyframes(withDuration: DRConstants.DRTitleAnimationeDuration, delay: 0.0, options: [], animations: {
            
            
            UIView.addKeyframe(withRelativeStartTime: DRConstants.DRTitleAnimationFirstRelativeStartTime, relativeDuration: DRConstants.DRTitleAnimationRelativeDuration, animations: {
                self.hardButton.center.x -= self.view.frame.width * 3 / 4
                self.hardButton.alpha = 1
            })
            
            UIView.addKeyframe(withRelativeStartTime: DRConstants.DRTitleAnimationSecondRelativeStartTime, relativeDuration: DRConstants.DRTitleAnimationRelativeDuration, animations: {
                self.normalButton.center.x -= self.view.frame.width * 3 / 4
                self.normalButton.alpha = 1
            })
            
            
            UIView.addKeyframe(withRelativeStartTime: DRConstants.DRTitleAnimationThirdRelativeStartTime, relativeDuration: DRConstants.DRTitleAnimationRelativeDuration, animations: {
                self.easyButton.center.x -= self.view.frame.width * 3 / 4
                self.easyButton.alpha = 1
            })

            UIView.addKeyframe(withRelativeStartTime: DRConstants.DRTitleAnimationFourthRelativeStartTime, relativeDuration: DRConstants.DRTitleAnimationRelativeDuration, animations: {
                self.levelLabel.center.x -= self.view.frame.width * 3 / 4
                self.levelLabel.alpha = 1
            })
            
        }) { _ in
            self.isAnimating = false
        }
    }
    
    
    func stoneControlFadeOutAnimation() {
        
        if self.isAnimating { return }
        
        self.isAnimating = true
        UIView.animateKeyframes(withDuration: DRConstants.DRTitleAnimationeDuration, delay: 0.0, options: [], animations: {

            UIView.addKeyframe(withRelativeStartTime: DRConstants.DRTitleAnimationFirstRelativeStartTime, relativeDuration: DRConstants.DRTitleAnimationRelativeDuration, animations: {
                self.stoneLabel.center.x += self.view.frame.width * 3 / 4
                self.stoneLabel.alpha = 0
            })

            UIView.addKeyframe(withRelativeStartTime: DRConstants.DRTitleAnimationSecondRelativeStartTime, relativeDuration: DRConstants.DRTitleAnimationRelativeDuration, animations: {
                self.blackButton.center.x += self.view.frame.width * 3 / 4
                self.blackButton.alpha = 0
            })

            UIView.addKeyframe(withRelativeStartTime: DRConstants.DRTitleAnimationThirdRelativeStartTime, relativeDuration: DRConstants.DRTitleAnimationRelativeDuration, animations: {
                self.whiteButton.center.x += self.view.frame.width * 3 / 4
                self.whiteButton.alpha = 0
            })

            UIView.addKeyframe(withRelativeStartTime: DRConstants.DRTitleAnimationFourthRelativeStartTime, relativeDuration: DRConstants.DRTitleAnimationRelativeDuration, animations: {
                self.backButton.center.x += self.view.frame.width * 3 / 4
                self.backButton.alpha = 0
            })
            
        }) { _ in
            self.levelControlFadeInAnimation()
        }
    }
    
    private func stoneControlFadeInAnimation() {
        
        UIView.animateKeyframes(withDuration: DRConstants.DRTitleAnimationeDuration, delay: 0.0, options: [.allowUserInteraction], animations: {

            
            UIView.addKeyframe(withRelativeStartTime: DRConstants.DRTitleAnimationFirstRelativeStartTime, relativeDuration: DRConstants.DRTitleAnimationRelativeDuration, animations: {
                self.backButton.center.x -= self.view.frame.width * 3 / 4
                self.backButton.alpha = 1
            })
            
            
            UIView.addKeyframe(withRelativeStartTime: DRConstants.DRTitleAnimationSecondRelativeStartTime, relativeDuration: DRConstants.DRTitleAnimationRelativeDuration, animations: {
                self.whiteButton.center.x -= self.view.frame.width * 3 / 4
                self.whiteButton.alpha = 1
            })
            
            
            UIView.addKeyframe(withRelativeStartTime: DRConstants.DRTitleAnimationThirdRelativeStartTime, relativeDuration: DRConstants.DRTitleAnimationRelativeDuration, animations: {
                self.blackButton.center.x -= self.view.frame.width * 3 / 4
                self.blackButton.alpha = 1
            })
            
            UIView.addKeyframe(withRelativeStartTime: DRConstants.DRTitleAnimationFourthRelativeStartTime, relativeDuration: DRConstants.DRTitleAnimationRelativeDuration, animations: {
                self.stoneLabel.center.x -= self.view.frame.width * 3 / 4
                self.stoneLabel.alpha = 1
            })



            
        }) { _ in
            self.isAnimating = false
        }
    }
    
}
