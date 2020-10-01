//
//  ServiceConfig.swift
//  Sunping
//
//  Created by dede wang on 2019/11/20.
//  Copyright © 2019 com.zxc. All rights reserved.
//

import UIKit

let BaseURL = ServiceConfigure.baseURL

struct ServiceConfigure {
    
    static let apiEnvironment: YY_ApiEnvironment = .test
    //
    static var baseURL: String  {
        return apiEnvironment.base()
    }
}

enum YY_ApiEnvironment: String  {
    
    /********外部环境**********/
    case mock = "https://mock.yonyoucloud.com/mock/3368/"
    case test = "http://djwy.nat300.top/"
    case product = "https://djwy-api.js56918.com/"
    func base() -> String {
        return self.rawValue
    }
}

//-------------------------------------项目自身接口------------------------------------

//发送注册短信验证码
let URL_SendRegisterSmsCode = BaseURL + "App-Sms/regist/"
//发送重置短信验证码
let URL_SendResetSmsCode = BaseURL + "App-Sms/resetPassWord/"
//app注册接口
let URL_Register = BaseURL + "App-user/userRegist"
//APP登录接口
let URL_Login = BaseURL + "App-user/userlogin"
//重置登录密码
let URL_ResetPassword = BaseURL + "App-user/resetPassword"
//获取首页轮播图
let URL_GetHomeImages = BaseURL + "App-qiniucloud/getHomeImages"
//获取订单列表
let URL_GetMyAppOrders = BaseURL + "App-order/getMyAppOrders"
//获取用户信息
let URL_GetUserInfo = BaseURL + "App-userAccount/userCenter"









//获取开单模块订单列表
let URL_MyOrderList = BaseURL + "queryMyOrderList"
//添加联系人
let URL_InsertTopContacts = BaseURL + "insertTopContacts"
//获取常用联系人列表
let URL_QueryTopContacts = BaseURL + "queryTopContacts"
//更新联系人
let URL_UpdateTopContacts = BaseURL + "updateTopContacts"
//删除常用联系人
let URL_DeleteTopContacts = BaseURL + "deleteTopContacts"

//获取货物类型列表
let URL_QueryGoodsType = BaseURL + "queryGoodsType"
//查询货物名称
let URL_QueryGoods = BaseURL + "queryGoods"

// 服务协议
let servicePath = BaseURL + "App-user/user_agreement"
// 隐私协议
let privacePath = BaseURL + "App-user/privacy_agreement"
// 授权协议“
let accreditPath = BaseURL + "App-user/authorize_agreement"
