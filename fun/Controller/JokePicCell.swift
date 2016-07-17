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

class JokePicCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let dateLable = UILabel()
    let picImageView = YYAnimatedImageView()
    
    var jokePicItem: JSON? {
        didSet {
            let json = jokePicItem
            picImageView.yy_imageURL = NSURL(string: json!["img"].stringValue)
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
        
        picImageView.contentMode = UIViewContentMode.ScaleAspectFit
        let superview = self.contentView
        superview.addSubview(picImageView)
        picImageView.snp_makeConstraints { (make) in
            make.edges.equalTo(superview)
        }
        
        self.textLabel?.hidden = true
    }
}
