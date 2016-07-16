//
//  JokeSplitViewController.swift
//  fun
//
//  Created by hongjy on 16/7/16.
//  Copyright © 2016年 hongjy. All rights reserved.
//

import UIKit

class JokeSplitViewController: UISplitViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        let splitViewController = self
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
        splitViewController.delegate = self
    }
    
    // MARK: - Split view
    
    func splitViewController(splitViewController: UISplitViewController,
                             collapseSecondaryViewController secondaryViewController:UIViewController,
                             ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? JokeDetailViewController else { return false }
        if topAsDetailController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
}
