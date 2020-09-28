//
//  NBCacheManager.swift
//  NoteBook
//
//  Created by dede wang on 2019/10/20.
//  Copyright © 2019 com.boc. All rights reserved.
//

import UIKit

// MARK - 对外暴露接口，用户只可以使用这两个接口进行数据的存储
protocol ICacheManager {
    func get<T>(key: String, type: StoreType) -> T?
    func set<T>(key: String, type: StoreType, data: T) -> StoreErrorCode
}

class NBCacheManager: ICacheManager {
    let fileCache = NBFileCache()
    let userDefault = NBDefaultCache()
    let plistCache = NBPlistCache()

    private static var _sharedInstance: NBCacheManager?

    class func getShared() -> NBCacheManager {
        guard let instance = _sharedInstance else {
           _sharedInstance = NBCacheManager()
           return _sharedInstance!
        }
        return instance
    }
    // 私有化init方法
    private init() {

    }
    //销毁单例对象
    class func destroy() {
        _sharedInstance = nil
    }
    
    /// 唯一数据存储方法，支持数据加密处理
    ///
    /// - Parameters:
    ///   - key: 存储的路径
    ///   - type: 数据存储方式
    /// - Returns: 返回是否存储成功
    func set<T>(key: String, type: StoreType, data: T) -> StoreErrorCode {
        switch type {
        case .file:
            return fileCache.set(key: key, data: data)
        case .plist:
            return plistCache.set(key: key, data: data)
        case .userDefault:
            return userDefault.set(key: key, data: data)
        }
    }
    
    /// 唯一数据获取方法，支持数据解密处理
    ///
    /// - Parameters:
    ///   - key: 存储的路径
    ///   - type: 数据存储方式
    ///   - isDecrypt: 是否需要解密
    /// - Returns: 返回用户存储的数据
    func get<T>(key: String, type: StoreType) -> T? {
        switch type {
        case .file:
            return fileCache.get(key: key)
        case .plist:
            return plistCache.get(key: key)
        case .userDefault:
            return userDefault.get(key: key)
        }
    }
}
