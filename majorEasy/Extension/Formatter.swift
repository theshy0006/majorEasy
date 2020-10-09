//
//  Formatter.swift
//  majorEasy
//
//  Created by wangyang on 2020/4/10.
//  Copyright © 2020 com.boc. All rights reserved.
//

import Foundation

/* 用法演示
let dateString = Formatter.iso8601.string(from: Date())   // "2018-01-23T03:06:46.232Z"
   

if let date = Formatter.iso8601.date(from: dateString)  {
    print(date)   // "2018-01-23 03:06:46 +0000\n"
}
*/


extension Formatter {
    static let iso8601: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
}
