//
//  StringUtil.swift
//  fun
//
//  Created by hongjy on 16/7/13.
//  Copyright © 2016年 hongjy. All rights reserved.
//

import Foundation

public func filterHtml(_ html : String) -> String {
    var text = html
    let scanner = Scanner(string:text)
    while !scanner.isAtEnd {
        scanner.scanUpTo("<", into: nil)
        var tag : NSString?
        scanner.scanUpTo(">", into: &tag)
        if tag != nil {
            text = text.replacingOccurrences(of: String(tag!) + ">", with: "")
        }
    }
    return text
}
