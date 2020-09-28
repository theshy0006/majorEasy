//
//  NBModel.swift
//  yunyou
//
//  Created by wangyang on 2020/3/31.
//  Copyright © 2020 com.boc. All rights reserved.
//

import UIKit

class NBModel: Codable {

}

class ProtocolModel: NBModel {
    
    /// 协议所属品牌 example：VW
    var brand = ""
    
    /// 协议代码 example: register
    var code = ""
    
    ///
    var localContent = ""
    
    /// 协议内容 example: 欢迎加入大众移动互联服务,..........
    var contentUrl = ""
    
    /// 协议编号 example: 123
    var id = ""
    
    /// 是否需要更新协议内容
    var isNeedSign: Bool = false
    
    /// 当前协议的最新版本
    var newVersion: String = ""
    
    /// 协议标题 example: 大众移动互联协议
    var title = ""
}

class UserInfoModel : NBModel {
    
    /// 用户头像URL地址
    var avatar: String = ""
    
    /// 用户手机号
    var mobile: String = ""
    
    /// 用户昵称
    var nickName: String = ""
    
    /// 用户头像URL地址
    var portrait: String = ""
    
    /// 大众用户编号（未绑定过车辆的用户为空）
    var svwUserId: String = ""
    
    /// MOS用户编号
    var userId: String = ""
    
}
