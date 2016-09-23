//
//  JokeMainViewController.swift
//  fun
//
//  Created by hongjy on 16/9/3.
//  Copyright © 2016年 hongjy. All rights reserved.
//

import UIKit
import SnapKit

class JokeMainViewController: UIViewController {
    
    let segmentedControl : UISegmentedControl = UISegmentedControl.init(items: ["文本笑话", "图文笑话"]);
    let textJokeController = JokeMasterViewController()
    let imageJokeController = ImageJokeTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 延长2秒, 显示开屏页
        Thread.sleep(forTimeInterval: 2.0)
        
        initSegmentedControl()
        setSegmentView()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.navigationBar.isTranslucent = false;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initSegmentedControl() {
        segmentedControl.addTarget(self,
                                   action: #selector(segmentedControlChanged(_:)),
                                   for: UIControlEvents.valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        self.navigationItem.titleView = segmentedControl
    }
    
    func segmentedControlChanged(_ segmentedControl: UISegmentedControl) {
        setSegmentView()
    }
    
    func setSegmentView() {
        let viewController = viewControllerForSegmentIndex(segmentedControl.selectedSegmentIndex)
        let superview = self.view
        superview?.addSubview(viewController.view)
        self.addChildViewController(viewController)
        viewController.view.snp.makeConstraints { (make) in
            make.edges.equalTo(superview!)
        }
        self.title = viewController.title
    }
    
    func viewControllerForSegmentIndex(_ index: Int) -> UIViewController {
        if (index == 0) {
            return textJokeController
        } else {
            return imageJokeController
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
