//
//  NBCacheBehavior.swift
//  NoteBook
//
//  Created by dede wang on 2019/10/20.
//  Copyright © 2019 com.boc. All rights reserved.
//

import UIKit

//数据存储方式
enum StoreType {
    case plist
    case file
    case userDefault
}

// TODO: 6个0代表成功, 其他错误可以扩展
enum StoreErrorCode: String {
    case success   = "000000"   //存储或者读取成功
    case getError  = "100001"  //读取数据错误
    case setError  = "200001"  //存储数据错误
    case typeError = "300001" //数据类型错误
    case pathError = "400001" //路径错误
}

// MARK - 存储和读取数据接口定义
protocol NBCacheBehavior {
    //获取数据行为
    func get<T>(key: String) -> T?
    //存储数据行为
    func set<T>(key: String, data: T) -> StoreErrorCode
}
