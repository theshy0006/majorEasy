//
//  DataCenterManager.swift
//  NoteBook
//
//  Created by dede wang on 2019/10/20.
//  Copyright © 2019 com.boc. All rights reserved.
//

import UIKit
import HandyJSON

class DataCenterManager: NSObject {

    static let `default` = DataCenterManager()
    /// 用户名
    var userInfo: UserInfo = UserInfo()
    var myInfo: MyInfo = MyInfo()
    /// 是否登录
    var isLogin: Bool = false
    // 用户信息本地化存储
    func save() {
        let result = NBCacheManager.getShared().set(key: "UserInfo", type: .file, data: self.userInfo.toJSONString()?.data(using: String.Encoding.utf8))
        print(result)
    }
    // 加载缓存用户信息
    func load() {
        guard let data:Data = NBCacheManager.getShared().get(key: "UserInfo", type: .file) else {return}
        let userInfoStr = String(data: data, encoding: String.Encoding.utf8)
        
        if let object = UserInfo.deserialize(from: userInfoStr) {
            self.userInfo = object
            if (self.userInfo.token?.count != 0) {
                self.isLogin = true
            }
        }
    }
    func clear() {
        self.userInfo = UserInfo()
        self.myInfo = MyInfo()
        self.isLogin = false
        self.save()
    }

}
