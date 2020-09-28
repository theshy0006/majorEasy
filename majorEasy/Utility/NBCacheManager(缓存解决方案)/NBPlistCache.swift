//
//  NBPlistCache.swift
//  NoteBook
//
//  Created by dede wang on 2019/10/20.
//  Copyright © 2019 com.boc. All rights reserved.
//

import UIKit

// plist 存储
class NBPlistCache : NBCacheBehavior {
    
    func get<T>(key: String) -> T? {
       return self.checkGetDataValidity(fileName: key, path: .cache)
    }
    
    //TODO: 内容需要重写,需要把是否存储成功返回
    func set<T>(key: String, data: T) -> StoreErrorCode {
       return self.checkSetValidity(key: key, data: data)
    }
}

// MARK - 路径相关
extension NBPlistCache {
    /// 获取文件路径
    ///
    /// - Parameters:
    ///   - fileName: 文件的名称
    ///   - path: 存储的根目录
    /// - Returns: 该文件存储的完整路径
    func dataFilePath(fileName: String, path: FilePath) -> String {
        return NSHomeDirectory().appending(path.rawValue).appending(self.makePlistPath(fileName))
    }
    
    func makePlistPath(_ fileName: String) -> String {
        if fileName.contains(".plist") {
            return fileName
        } else {
            return "\(fileName).plist"
        }
    }
}
// MARK - 存储行为
extension NBPlistCache {
    ///
    /// - Parameters:
    ///   - fileName: 文件名称
    ///   - path: 根目录路径
    /// - Returns: 存储的数据
    private func checkGetDataValidity<T>(fileName: String, path: FilePath) -> T? {
        if let data = self.getNSArray(fileName: fileName, path: path) {
            guard let item = data as? T else {return nil}
            return item
        } else if let data = self.getNSDictionary(fileName: fileName, path: path) {
            guard let item = data as? T else {return nil}
            return item
        } else if let data = self.getNSData(fileName: fileName, path: path) {
            guard let item = data as? T else {return nil}
            return item
        } else {return nil}
    }
    
    private func checkSetValidity<T>(key: String, data: T) -> StoreErrorCode {
        if let item = data as? NSArray {
            return self.setNSArray(fileName: key, data: item, path: .cache)
        } else if let item = data as? NSDictionary {
            return self.setNSDictionary(fileName: key, data: item, path: .cache)
        } else if let item = data as? NSData {
            return self.setNSData(fileName: key, data: item, path: .cache)
        } else {return .typeError}
    }
    
    func setNSArray(fileName: String, data: NSArray, path: FilePath) -> StoreErrorCode {
        if data.write(toFile: self.dataFilePath(fileName: fileName, path: path), atomically: true) {
            return .success
        } else {
            return .setError
        }
    }
    
    func setNSDictionary(fileName: String, data: NSDictionary, path: FilePath) -> StoreErrorCode {
        if data.write(toFile: self.dataFilePath(fileName: fileName, path: path), atomically: true) {
            return .success
        } else {
            return .setError
        }
    }
    
    func setNSData(fileName: String, data: NSData, path: FilePath) -> StoreErrorCode {
        if data.write(toFile: self.dataFilePath(fileName: fileName, path: path), atomically: true) {
            return .success
        } else {
            return .setError
        }
    }
    
    func getNSArray(fileName: String, path: FilePath) -> NSArray? {
        guard let data = NSArray(contentsOfFile: self.dataFilePath(fileName: fileName, path: path)) else {return nil}
        return data
    }
    
    func getNSDictionary(fileName: String, path: FilePath) -> NSDictionary? {
        guard let data = NSDictionary(contentsOfFile: self.dataFilePath(fileName: fileName, path: path)) else {return nil}
        return data
    }
    
    func getNSData(fileName: String, path: FilePath) -> NSData? {
        guard let data = NSData(contentsOfFile: self.dataFilePath(fileName: fileName, path: path)) else {return nil}
        return data
    }
}

