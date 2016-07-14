//
//  StringUtil.swift
//  fun
//
//  Created by hongjy on 16/7/13.
//  Copyright © 2016年 hongjy. All rights reserved.
//

import Foundation

public func filterHtml(html : String) -> String {
    var text = html
    let scanner = NSScanner(string:text)
    while !scanner.atEnd {
        scanner.scanUpToString("<", intoString: nil)
        var tag : NSString?
        scanner.scanUpToString(">", intoString: &tag)
        if tag != nil {
            text = text.stringByReplacingOccurrencesOfString(String(tag!) + ">", withString: "")
        }
    }
    return text
}
