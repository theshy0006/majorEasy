//
//  SVW_PayResultEnums.swift
//  MosProject
//
//  Created by 赵迪 on 2019/3/14.
//  Copyright © 2019年 SVW. All rights reserved.
//

import UIKit

struct InformationDeliveryConstant {
    static let Safepay = "safepay"
    static let payResultSuccess = "9000"
    static let payResultFail = "4000"
    static let payResultCancel = "6001"
    static let WXPayResultSuccess: Int32 = 0
    static let WXPayResultError: Int32 = -1
    static let WXPayResultCancel: Int32 = -2
    static let Action1 = "action1"
    static let Action2 = "action2"
    static let Test1 = "test1"
    static let Test2 = "test2"
    static let Test_category = "test_category"
}

/// 订单支付结果
enum PayOrderResult: String {
    
    /// 支付成功
    case success = "success"
    
    /// 支付失败
    case fail = "fail"
    
    /// 支付取消
    case cancel = "cancel"
    
    /// 未知情况
    case unknow = "unknow"
    
    /// 待系统确认
    case confirm = "confirm"
    
    /// 不同支付结果对应的导航栏 title
    var title: String {
        switch self {
        case .success:
            return "支付完成"
        case .fail:
            return "支付失败"
        case .confirm:
            return "支付待确认"
        default:
            return "支付超时"
        }
    }
    
    /// 支付结果对应的提示文字
    var tipText: String {
        switch self {
        case .success:
            return "支付完成"
        case .fail:
            return "支付失败"
        case .confirm:
            return "支付完成，待系统确认"
        default:
            return "支付超时"
        }
    }
    
    /// 支付结果对应的提示图片
    var tipImage: UIImage? {
        switch self {
        case .success:
            return UIImage(named: "order_pay_success")
        case .fail:
            return UIImage(named: "order_pay_failed")
        case .confirm:
            return UIImage(named: "order_pay_confirm")
        default:
            return UIImage(named: "order_pay_unknow")
        }
    }
}


/// 发起支付的最初界面，以便3s后返回
enum PayFromOriginType {
    
    case none
    
    /// 订单列表
    case orderList
    
    /// 订单详情
    case orderDetail
    
    /// 商品列表
    case payPage
    
    /// 会员详情页
    case vipDetail
    
    /// 违章查询
    case violationInquire
    
    /// 违章历史
    case violationHistory
    
    /// 倒计时按钮显示文字
    var countDownButtonTitle: String {
        switch self {
        case .orderList:
            return "回到订单列表页"
        case .payPage:
            return "回到在线媒体服务页"
        case .vipDetail:
            return "回到会员详情页"
        case .violationInquire:
            return "回到违章查询页"
        case .violationHistory:
            return "回到违章历史页"
        case .orderDetail:
            return "查看订单详情"
        case .none:
            return ""
        }
    }
}
