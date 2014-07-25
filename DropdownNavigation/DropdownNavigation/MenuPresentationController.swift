//
//  MenuPresentationController.swift
//  DropdownNavigation
//
//  Created by Josip Cavar on 24/07/14.
//  Copyright (c) 2014 Josip Cavar. All rights reserved.
//

import UIKit

class MenuPresentationController: UIPresentationController {
   
    var dimmingView: UIView = UIView();
    
    init(presentedViewController: UIViewController!, presentingViewController: UIViewController!)  {
        
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        prepareDimmingView()
    }
    
    func prepareDimmingView() {

        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
        dimmingView.alpha = 0
        var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("dimmingViewTapped:"))
        dimmingView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func dimmingViewTapped(gestureRecognizer: UIGestureRecognizer) {
        
        if (gestureRecognizer.state == .Ended) {
            presentingViewController.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    override func presentationTransitionWillBegin() {

        dimmingView.frame = containerView.bounds
        dimmingView.alpha = 0.0
        containerView.insertSubview(dimmingView, atIndex: 0)
        
        if(presentedViewController.transitionCoordinator()) {
            presentedViewController.transitionCoordinator().animateAlongsideTransition({context in
                self.dimmingView.alpha = 1.0
                }, completion: nil)
        } else {
            dimmingView.alpha = 1.0
        }
    }
    
    override func dismissalTransitionWillBegin() {
        
        if (self.presentedViewController.transitionCoordinator()) {
            presentedViewController.transitionCoordinator().animateAlongsideTransition({context in
                self.dimmingView.alpha = 0.0
                }, completion: nil)
        } else {
            dimmingView.alpha = 0.0
        }
    }
    
    override func adaptivePresentationStyle() -> UIModalPresentationStyle  {
        
        return .Custom
    }
    
    override func sizeForChildContentContainer(container: UIContentContainer!, withParentContainerSize parentSize: CGSize) -> CGSize  {
        
        return CGSize(width: parentSize.width / 1.5, height: parentSize.height / 1.5)
    }
    
    override func containerViewWillLayoutSubviews()  {
        
        dimmingView.frame = containerView.bounds
        presentedView().frame = frameOfPresentedViewInContainerView()
    }
    
    override func shouldPresentInFullscreen() -> Bool  {
        
        return false
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect  {
        
        var presentedViewFrame: CGRect = CGRectZero;
        
        presentedViewFrame.size = sizeForChildContentContainer(presentedViewController, withParentContainerSize: containerView.bounds.size)
        
        presentedViewFrame = animateFromLeftRect(presentedViewFrame)
        
        return presentedViewFrame;
    }
    
    func animateFromTopRect(frame: CGRect) ->CGRect {
        
        var newFrame: CGRect = frame
        newFrame.origin = CGPoint(x: (containerView.frame.size.width - newFrame.width) / 2, y: 0);
        return newFrame
    }
    
    func animateFromBottomRect(frame: CGRect) ->CGRect {
        
        var newFrame: CGRect = frame
        newFrame.origin = CGPoint(x: (containerView.frame.size.width - newFrame.width) / 2, y: containerView.frame.height - newFrame.height);
        return newFrame
    }
    
    func animateFromLeftRect(frame: CGRect) ->CGRect {
        
        var newFrame: CGRect = frame
        newFrame.origin = CGPoint(x: 0, y: 0);
        return newFrame
    }
}
