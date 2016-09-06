//
//  MasterViewController.swift
//  fun
//
//  Created by hongjy on 16/7/7.
//  Copyright © 2016年 hongjy. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
import SwiftyJSON
import SwiftDate

class JokeMasterViewController: UITableViewController {

    var detailViewController: JokeDetailViewController? = nil
    var objects: Array<JSON> = [];
    var pageIdx = 1;
    let jokeApiUrl = "http://apis.baidu.com/showapi_open_bus/showapi_joke/joke_text"

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
//        self.navigationItem.leftBarButtonItem = self.editButtonItem()
//        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(insertNewObject(_:)))
//        self.navigationItem.rightBarButtonItem = addButton
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? JokeDetailViewController
        }
        
        self.tableView.mj_header =
            MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(reload))
        self.tableView.mj_header.beginRefreshing()
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.tableView.tableFooterView = UIView.init(frame: CGRectZero);
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.title = "文本笑话"
        self.view.backgroundColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        // TODO: customize UITableViewCell
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")

        let object = objects[indexPath.row]
        cell.textLabel!.text = object["title"].stringValue
        
        var dateString = object["ct"].stringValue
        let date = dateString.toDate(DateFormat.Custom("yyyy-MM-dd HH:mm:ss.SSS"))!
        dateString = date.toString(DateFormat.Custom("MM-dd HH:mm"))!
        cell.detailTextLabel!.text = dateString
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let object = objects[indexPath.row]
        let controller = JokeDetailViewController()
        controller.detailItem = object
        self.navigationController?.pushViewController(controller, animated: true)
//        controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
//        controller.navigationItem.leftItemsSupplementBackButton = true
    }
    
    // MARK: - Refresh
    
    func reload() {
        self.objects = []
        pageIdx = 1
        request(.GET,
            jokeApiUrl,
            parameters: [ "page" : String(pageIdx) ],
            headers: [ "apikey" : BAIDU_API_KEY])
            .responseJSON { response in
                if let value = response.result.value {
                    let json = JSON(value)
                    let array =  json["showapi_res_body"]["contentlist"].arrayValue
                    self.objects = array
                    self.pageIdx += 1;
                    self.tableView.reloadData()
                    
                    self.tableView.mj_header.endRefreshing()
                    self.tableView.mj_footer =
                        MJRefreshAutoNormalFooter(refreshingTarget: self,
                            refreshingAction: #selector(self.loadMore))
                }
        }
    }

    func loadMore() {
        request(.GET,
            jokeApiUrl,
            parameters: [ "page" : String(pageIdx) ],
            headers: [ "apikey" : BAIDU_API_KEY])
            .responseJSON { response in
                if let value = response.result.value {
                    let json = JSON(value)
                    let array =  json["showapi_res_body"]["contentlist"].arrayValue
                    self.objects = self.objects + array
                    self.pageIdx += 1;
                    self.tableView.reloadData()
                    
                    self.tableView.mj_footer.endRefreshing()
                    if (array.count < 20) {
                        self.tableView.mj_footer.endRefreshingWithNoMoreData()
                    }
                }
        }
    }
}
