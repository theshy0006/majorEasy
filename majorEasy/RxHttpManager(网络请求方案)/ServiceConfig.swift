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
    case test = "http://351905u84w.wicp.vip/"
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
//添加熟车
let URL_AddMyFamiliarVehicle = BaseURL + "App-userAccount/addMyFamiliarVehicle"
// 获取消费记录
let URL_GetAccountRecord = BaseURL + "App-userAccount/getAccountRecord"
// 获取专线列表
let URL_GetDedicatedLines = BaseURL + "App-delicatedLine/getDedicatedLines"
// 获取专线详情
let URL_GetDedicatedLineDetail = BaseURL + "App-delicatedLine/GetDedicatedLineDetail/"

// 获取我的专线
let URL_GetMyDedicatedLines = BaseURL + "App-delicatedLine/getMyDedicatedLines"
// 获取我的熟车
let URL_GetMyFamiliarVehicles = BaseURL + "App-vehicle/getMyFamiliarVehicles"
// 获取车源
let URL_GetAllvehicles = BaseURL + "App-vehicle/getAllvehicles"
// 获取车主交易记录
let URL_GetVehicleOwnerOrderRecords = BaseURL + "App-order/getVehicleOwnerOrderRecords"
// 获取常跑路线
let URL_GetMyRegularRoutes = BaseURL + "App-vehicle/getMyRegularRoutes"
// 添加常跑路线
let URL_AddRegularRoute = BaseURL + "App-vehicle/addRegularRoute"
// 获取我的车牌
let URL_GetMyLicenseNubmers = BaseURL + "App-vehicle/getMyLicenseNubmers"
// 查询承运人
let URL_SerachCarrier = BaseURL + "App-user/serachCarrier"
// 获取板车品牌列表
let URL_GetFlatbedCompanys = BaseURL + "App-vehicle/getFlatbedCompanys"
// 获取我的货源列表：常发，历史，发货中公用此接口
let URL_getMySupplies = BaseURL + "App-supply/getMySupplies"
// 删除货源
let URL_deletMysupply = BaseURL + "App-supply/deletMysupply/"
// 所有货源
let URL_GetSuppliesByParam = BaseURL + "App-supplies/getSuppliesByParam"
// 身份证正面上传
let URL_UploadIdCardFront = BaseURL + "App-qiniuAccountcloud/uploadIdCardFront"
// 身份证反面上传
let URL_UploadIdCardReverse = BaseURL + "App-qiniuAccountcloud/uploadIdCardReverse"
// 头像上传
let URL_Uploadheadportrait = BaseURL + "App-qiniuAccountcloud/uploadheadportrait"
// 更新用户信息
let URL_SaveUserInfo = BaseURL + "App-userAccount/saveUserInfo"
// 提交审核接口
let URL_SubUserReview = BaseURL + "App-userAccount/subUserReview"
// 奖励榜单
let URL_GetIntegralRankList = BaseURL + "App-userAccount/getIntegralRankList"
// 充值榜单
let URL_GetRechargeRankList = BaseURL + "App-userAccount/getRechargeRankList"
// 邀请榜单
let URL_GetInviteRankList = BaseURL + "App-userAccount/getInviteRankList"
// 获取分享链接
let URL_GetMyShareUrl = BaseURL + "App-userAccount/getMyShareUrl"
//账单列表
let URL_GetRecords = BaseURL + "App-userAccount/getRecords"
//充值列表
let URL_GetRechargeRecord = BaseURL + "App-userAccount/getRechargeRecord"
//提现列表
let URL_GetWithdrawalRecord = BaseURL + "App-userAccount/getWithdrawalRecord"
// 发货主交易接口
let URL_SendGoods = BaseURL + "App-supply/realseSupply"
//获取推荐报价
let URL_GetReferencePrice = BaseURL + "App-supply/getReferencePrice"
//获取货物类型
let URL_GetAllGoodsType = BaseURL + "App-supplies/getAllGoodsType"
//查询指派人
let URL_SearchCarrier = BaseURL + "App-user/serachCarrier/"

//完成订单
let URL_FinishOrder = BaseURL + "App-order/finishOrder/"
//取消订单
let URL_CancleOrder = BaseURL + "App-order/cancleOrder/"
//添加通讯录
let URL_AddAddressBook = BaseURL + "App-userAccount/addUserAddressBook"


// 服务协议
let servicePath = BaseURL + "App-user/user_agreement"
// 隐私协议
let privacePath = BaseURL + "App-user/privacy_agreement"
// 授权协议
let accreditPath = BaseURL + "App-user/authorize_agreement"


