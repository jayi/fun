//
//  JokeDetailViewController.swift
//  fun
//
//  Created by hongjy on 16/7/7.
//  Copyright © 2016年 hongjy. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftDate

class JokeDetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    var detailItem: JSON? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                var text = detail["text"].stringValue
                text = filterHtml(text)
                label.text = text
            }
            
            self.navigationItem.title = detail["title"].stringValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}