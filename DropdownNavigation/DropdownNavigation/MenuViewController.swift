//
//  MenuViewController.swift
//  DropdownNavigation
//
//  Created by Josip Cavar on 23/07/14.
//  Copyright (c) 2014 Josip Cavar. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate {
    
    func viewControllerDidChooseColor(viewController: UIViewController, color: UIColor)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableViewColors: UITableView!
    var delegate: MenuViewControllerDelegate?
    var colors = [UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1),
                  UIColor(red: 255.0/255.0, green: 59.0/255.0, blue: 48.0/255.0, alpha: 1),
                  UIColor(red: 76.0/255.0, green: 217.0/255.0, blue: 100.0/255.0, alpha: 1),
                  UIColor(red: 255.0/255.0, green: 204.0/255.0, blue: 0.0/255.0, alpha: 1),
                  UIColor(red: 88.0/255.0, green: 86.0/255.0, blue: 214.0/255.0, alpha: 1),
                  UIColor(red: 255.0/255.0, green: 73.0/255.0, blue: 129.0/255.0, alpha: 1),
                  UIColor(red: 255.0/255.0, green: 211.0/255.0, blue: 224.0/255.0, alpha: 1)]
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableViewColors.tableFooterView = UIView(frame: CGRectZero)
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!  {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("ColorCell") as? UITableViewCell;
        if !cell {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "ColorCell")
        }
        cell!.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int  {
        
        return colors.count
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        delegate?.viewControllerDidChooseColor(self, color: colors[indexPath.row])
        dismissViewControllerAnimated(true, completion: nil)
        
    }
}
