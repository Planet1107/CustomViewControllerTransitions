//
//  ViewController.swift
//  DropdownNavigation
//
//  Created by Josip Cavar on 23/07/14.
//  Copyright (c) 2014 Josip Cavar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MenuViewControllerDelegate {
    
    var menuTransitioner :MenuTransitioner = MenuTransitioner()
    
    init(coder aDecoder: NSCoder!) {
        
        super.init(coder: aDecoder)
    }
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool)  {
        
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func barButtonItemShowMenuTouchUpInside(sender: AnyObject) {

        var menuViewController = MenuViewController(nibName: "MenuViewController", bundle: nil)
        menuViewController.delegate = self
        menuViewController.modalPresentationStyle = .Custom
        menuViewController.transitioningDelegate = menuTransitioner
        presentViewController(menuViewController, animated: true, completion: nil)
    }
    
    func viewControllerDidChooseColor(viewController: UIViewController, color: UIColor) {
        
        self.view.backgroundColor = color
    }
}

