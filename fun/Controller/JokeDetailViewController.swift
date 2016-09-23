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
import SnapKit

class JokeDetailViewController: UIViewController {

    let detailDescriptionLabel = UILabel()
    let scrollView = UIScrollView()
    let contentView = UIView()


    var detailItem: JSON? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            let label = self.detailDescriptionLabel
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 18)
            var text = detail["text"].stringValue
            text = filterHtml(text)
            label.text = text
            self.title = detail["title"].stringValue
        }
        
        var superview = contentView
        superview.addSubview(detailDescriptionLabel)
        detailDescriptionLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(superview).inset(UIEdgeInsetsMake(8, 8, 8, 8))
        }
        
        superview = scrollView
        superview.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(superview)
            make.centerX.equalTo(superview)
        }
        
        self.view.backgroundColor = UIColor.white
        superview = self.view
        superview.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(superview)
        }
        scrollView.alwaysBounceVertical = true
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
