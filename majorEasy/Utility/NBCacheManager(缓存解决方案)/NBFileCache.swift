//
//  NBFileCache.swift
//  NoteBook
//
//  Created by dede wang on 2019/10/20.
//  Copyright © 2019 com.boc. All rights reserved.
//

import UIKit

enum FilePath: String {
    case cache = "/Library/Caches/"
    case document = "/Documents/"
    case tmp = "/tmp"
}

class NBFileCache: NBCacheBehavior {
    func get<T>(key: String) -> T? {
        //读取原始数据
        return getOriginalData(key: key)
    }
    
    func set<T>(key: String, data: T) -> StoreErrorCode {
        //存储原始数据
        return setOriginalData(key: key, data: data)
    }
}

extension NBFileCache {
    /// 获取文件路径
    ///
    /// - Parameters:
    ///   - fileName: 文件的名称
    ///   - path: 存储的根目录
    /// - Returns: 该文件存储的完整路径
    func dataFilePath(fileName: String, path: FilePath) -> String {
        return NSHomeDirectory().appending(path.rawValue).appending(fileName)
    }
    
    // 读取原始数据
    func getOriginalData<T>(key: String, path: FilePath = .document) -> T? {
        guard let url = URL.init(string: self.dataFilePath(fileName: key, path: path)) else {return nil}
        guard let data = FileManager.default.contents(atPath: url.path) else {return nil}
        guard let item = data as? T else {return nil}
        return item
    }
    // 存储原始数据
    func setOriginalData<T>(key: String, data: T, path: FilePath = .document) -> StoreErrorCode {
        guard let item = data as? Data else {return .typeError}
        let fileURLPath = self.dataFilePath(fileName: key, path: path)
        if let url = URL.init(string: "file://\(fileURLPath)") {
            do {
                try item.write(to: url)
                return .success
            }
            catch let error as NSError {
                print("File存储失败: \(error)")
                return .setError
            }
        }
        return .setError
    }
}


