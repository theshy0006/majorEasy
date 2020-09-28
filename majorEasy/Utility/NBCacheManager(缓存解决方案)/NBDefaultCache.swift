//
//  NBDefaultCache.swift
//  NoteBook
//
//  Created by dede wang on 2019/10/20.
//  Copyright © 2019 com.boc. All rights reserved.
//

import UIKit

class NBDefaultCache: NBCacheBehavior {
    
    func get<T>(key: String) -> T? {
        //读取原始数据
        return getOriginalData(key: key)
    }
    
    func set<T>(key: String, data: T) -> StoreErrorCode {
        //存储原始数据
        return setOriginalData(key: key, data: data)
    }
}

extension NBDefaultCache {
    func getOriginalData<T>(key: String) -> T? {
        guard let item = UserDefaults.standard.object(forKey: key) as? T else {return nil}
        return item
    }
    func setOriginalData<T>(key: String, data: T) -> StoreErrorCode {
        UserDefaults.standard.set(data, forKey: key)
        return .success
    }
}
