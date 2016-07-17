//
//  HomeTableViewController.swift
//  fun
//
//  Created by hongjy on 16/7/16.
//  Copyright © 2016年 hongjy. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    let objects: Array<String> = ["文本笑话", "图文笑话"];
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 延长2秒, 显示开屏页
        NSThread.sleepForTimeInterval(2.0)

        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.tableFooterView = UIView.init(frame: CGRectZero);
        self.title = "笑话大全"
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = object
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(JokeMasterViewController(),
                                                          animated: true)
        } else {
            self.navigationController?.pushViewController(ImageJokeTableViewController(),
                                                          animated: true)
        }
    }
}
