//
//  JokePicCell.swift
//  fun
//
//  Created by hongjy on 16/7/17.
//  Copyright © 2016年 hongjy. All rights reserved.
//

import UIKit
import SnapKit
import YYWebImage
import SwiftyJSON
import SwiftDate

class JokePicCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let picImageView = YYAnimatedImageView()
    
    var jokePicItem: JSON? {
        didSet {
            let json = jokePicItem
            var url = json!["img"].stringValue
            url = url.stringByReplacingOccurrencesOfString("\"/></p>", withString: "")
            picImageView.yy_imageURL = NSURL(string: url)
            
            titleLabel.text = json!["title"].stringValue
            
            var dateString = json!["ct"].stringValue
            let date = dateString.toDate(DateFormat.Custom("yyyy-MM-dd HH:mm:ss.SSS"))!
            dateString = date.toString(DateFormat.Custom("MM-dd HH:mm"))!
            dateLabel.text = dateString
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let superview = self.contentView
        
        titleLabel.numberOfLines = 0
        titleLabel.setContentHuggingPriority(UILayoutPriorityRequired,
                                               forAxis: UILayoutConstraintAxis.Vertical)
        superview.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(superview).offset(8)
            make.left.equalTo(superview).offset(8)
            make.right.equalTo(superview).offset(-8)
        }
        
        dateLabel.font = UIFont.systemFontOfSize(12)
        dateLabel.textColor = UIColor.grayColor()
        dateLabel.setContentHuggingPriority(UILayoutPriorityRequired,
                                               forAxis: UILayoutConstraintAxis.Vertical)
        superview.addSubview(dateLabel)
        dateLabel.snp_makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(8)
            make.right.equalTo(superview).offset(-8)
        }
        
        picImageView.contentMode = UIViewContentMode.ScaleAspectFit
        picImageView.setContentHuggingPriority(UILayoutPriorityDefaultLow,
                                               forAxis: UILayoutConstraintAxis.Vertical)
        superview.addSubview(picImageView)
        picImageView.snp_makeConstraints { (make) in
            make.bottom.equalTo(superview).offset(-24)
            make.left.equalTo(superview)
            make.right.equalTo(superview)
            make.top.equalTo(dateLabel.snp_bottom).offset(8)
        }
        
        self.textLabel?.hidden = true
    }
}
