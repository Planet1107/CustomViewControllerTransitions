//
//  MenuTransitioner.swift
//  DropdownNavigation
//
//  Created by Josip Cavar on 24/07/14.
//  Copyright (c) 2014 Josip Cavar. All rights reserved.
//

import UIKit

class MenuTransitioner: NSObject {
   
    var isPresentation :Bool = false
}

extension MenuTransitioner : UIViewControllerTransitioningDelegate {
    
    func presentationControllerForPresentedViewController(presented: UIViewController!, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController!) -> UIPresentationController! {
        
        return MenuPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        
        isPresentation = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        
        isPresentation = false
        return self
    }
}

extension MenuTransitioner : UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning!) -> NSTimeInterval {
        
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning!) {
        
        var fromViewController: UIViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        var toViewController: UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        if(isPresentation == true) {
            transitionContext.containerView().addSubview(toViewController.view);
        }
        
        var animationViewController: UIViewController = isPresentation ? toViewController : fromViewController
        var appearedFrame: CGRect = transitionContext.finalFrameForViewController(animationViewController)
        var dismissedFrame: CGRect = appearedFrame;
        dismissedFrame = animateFromLeftRect(dismissedFrame)
        var initialFrame: CGRect = isPresentation ? dismissedFrame : appearedFrame;
        var finalFrame: CGRect = isPresentation ? appearedFrame : dismissedFrame;
        
        animationViewController.view.frame = initialFrame
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, usingSpringWithDamping: 300.0, initialSpringVelocity: 5.0, options: .AllowUserInteraction | .BeginFromCurrentState, animations: {
            animationViewController.view.frame = finalFrame
            }, completion: {finished in
                if (self.isPresentation == false) {
                    fromViewController.view.removeFromSuperview()
                }
                transitionContext.completeTransition(true)
            })
    }
    
    func animateFromTopRect(frame: CGRect) ->CGRect {
        
        var newFrame: CGRect = frame
        newFrame.origin.y -= newFrame.size.height;
        return newFrame
    }
    
    func animateFromBottomRect(frame: CGRect) ->CGRect {
        
        var newFrame: CGRect = frame
        newFrame.origin.y += newFrame.size.height;
        return newFrame
    }
    
    func animateFromLeftRect(frame: CGRect) ->CGRect {
        
        var newFrame: CGRect = frame
        newFrame.origin.x -= newFrame.size.width;
        return newFrame
    }
    
    func animateFromRightRect(frame: CGRect) ->CGRect {
        
        var newFrame: CGRect = frame
        newFrame.origin.x += newFrame.size.width;
        return newFrame
    }
}
