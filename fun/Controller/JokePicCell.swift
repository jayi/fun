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
            url = url.replacingOccurrences(of: "\"/></p>", with: "")
            picImageView.yy_imageURL = URL(string: url)
            
            titleLabel.text = json!["title"].stringValue
            
            var dateString = json!["ct"].stringValue
            let date = dateString.toDate(format: DateFormat.custom("yyyy-MM-dd HH:mm:ss.SSS"))!
            dateString = date.toString(format: DateFormat.custom("MM-dd HH:mm"))!
            dateLabel.text = dateString
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
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
                                               for: UILayoutConstraintAxis.vertical)
        superview.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(superview).offset(8)
            make.left.equalTo(superview).offset(8)
            make.right.equalTo(superview).offset(-8)
        }
        
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = UIColor.gray
        dateLabel.setContentHuggingPriority(UILayoutPriorityRequired,
                                               for: UILayoutConstraintAxis.vertical)
        superview.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.right.equalTo(superview).offset(-8)
        }
        
        picImageView.contentMode = UIViewContentMode.scaleAspectFit
        picImageView.setContentHuggingPriority(UILayoutPriorityDefaultLow,
                                               for: UILayoutConstraintAxis.vertical)
        superview.addSubview(picImageView)
        picImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(superview).offset(-24)
            make.left.equalTo(superview)
            make.right.equalTo(superview)
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
        }
        
        self.textLabel?.isHidden = true
    }
}
