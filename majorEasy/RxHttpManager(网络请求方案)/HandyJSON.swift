//
//  HandyJSON.swift
//  yunyou
//
//  Created by wangyang on 2020/4/3.
//  Copyright © 2020 com.boc. All rights reserved.
//

import HandyJSON

// 发送注册短信验证码返回对象
class RegisterCode: HandyJSON {
    
    var status: Int = 0
    var message: String?
    var value: String?

    required init() {}
}

// 发送重置短信验证码返回对象
class ResetCode: HandyJSON {
    
    var status: Int = 0
    var message: String?
    var value: String?

    required init() {}
}

// 注册接口返回对象
class RegisterModel: HandyJSON {
    
    var status: Int = 0
    var message: String?
    var value: String?

    required init() {}
}

// 重置登录密码返回对象
class ResetPasswordModel: HandyJSON {
    
    var status: Int = 0
    var message: String?
    var value: String?

    required init() {}
}

// 登录接口返回对象
class LoginModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: UserInfo = UserInfo()
    required init() {}
}

// 用户信息对象
class UserInfo: HandyJSON {
    var token: String?
    var idReview: Int?
    var userRole: Int?
    var userRealName: String?
    var phoneNumber: String?
    var vipLevel: Int?
    required init() {}
}

//首页轮播图对象
class HomeImagesModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: HomeImages = HomeImages()
    required init() {}
}

class HomeImages: HandyJSON {
    var carouselimages: [String] = []
    var functionImgs: [HomeItem] = [HomeItem]()
    required init() {}
}

class HomeItem: HandyJSON {
    var name: String?
    var url: String?
    required init() {}
}

//我的订单对象
class OrderModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: [OrderItem] = [OrderItem]()
    required init() {}
}

//订单对象
class OrderItem: HandyJSON {
    var appointment: String?
    var arrivalData: String?
    var arrivalTime: String?
    var carrierLicenseNum: String?
    var carrierName: String?
    var carrierPhoneNum: String?
    var consignorCfmFinTime: String?
    var consignorHeadPortraitKey: String?
    var consignorHeadPortraitUrl: String?
    var consignorId: Int = 0
    var consignorName: String?
    var consignorPhone: String?
    var consignorSign:Bool = false
    var consignorSignTime: String?
    var creatTime: String?
    var deliveryData: String?
    var deliveryTime: String?
    var distance: Int = 0
    var earnestMoney: Float = 0.0
    var goodsDiameter: Float = 0.0
    var goodsHeight: Float = 0.0
    var goodsLength: Float = 0.0
    var goodsName: String?
    var goodsRemarks: String?
    var goodsType: String?
    var goodsVolume_lower: Float = 0.0
    var goodsVolume_upper: Float = 0.0
    var goodsWeight_lower: Float = 0.0
    var goodsWeight_upper: Float = 0.0
    var goodsWide: Float = 0.0
    var ifpay:Bool = false
    var insuranceType: String?
    var latestPayDays: Int = 0
    var loadMode: String?
    var loadPerson: String?
    var loadPhoneNum: String?
    var loadPlace: String?
    var loadPlaceCode: String?
    var loadPlaceDetail: String?
    var loadSpareNum: String?
    var offerNum: String?
    var orderNum: String?
    var orderReceipt: String?
    var orderReceiptPic: String?
    var paymentCash: Int = 0
    var paymentOilCard: Int = 0
    var paymentOnline: Int = 0
    var paymentWay: String?
    var securityBond: Float = 0.0
    var state: Int = 0
    var status: String?
    var subOrderUserId: Int = 0
    var supplyNum: String?
    var totalFreightPrice: Float = 0.0
    var unloadPerson: String?
    var unloadPhoneNum: String?
    var unloadPlace: String?
    var unloadPlaceCode: String?
    var unloadPlaceDetail: String?
    var unloadSpareNum: String?
    var useMode: String?
    var userRole: Int = 0
    var vehicleLength: String?
    var vehicleOwnerHeadPortraitKey: String?
    var vehicleOwnerHeadPortraitUrl: String?
    var vehicleOwnerId: Int = 0
    var vehicleOwnerName: String?
    var vehicleOwnerPhone: String?
    var vehicleOwnerSign:Bool = false
    var vehicleOwnerSignTime: String?
    var vehicleType: String?
    var vehicleTypeId: Int = 0
    required init() {}
}



// 司机信息
class DriverInfo: HandyJSON {
    
    var driver_id: Int = 0
    //司机id
    var customer_id: Int = 0
    //客户id
    var driver_name: String?
    //司机姓名
    var driver_gender: String?
    //性别
    var driver_nation: String?
    //民族
    var driver_birth: String?
    //生日
    var driver_address: String?
    //地址
    var driver_mobile: String?
    //手机号
    var driver_IDNumber: String?
    //身份证号
    var driver_headImage_url: String?
    //头像url
    var driver_idCardImage_url: String?
    //身份证url
    var driver_license_url: String?
    //司机驾驶证URL
    var driver_certificate_url: String?
    //从业资格证照片URL
    var driver_bankCardNumber: String?
    //银行卡号
    var whetherIdentificate: Int?
    //是否实名认证

    required init() {}
}

// 默认车辆信息
class DefaultVehicle: HandyJSON {
    
    var vehicle_color: String?
    //车辆颜色
    var vehicle_number: String?
    //车牌号
    var vehicle_length: Int = 0
    //车长
    var vehicle_model: String?
    //车型
    var vehicle_deadweight: Int = 0
    //载重
    var whetherPassExamine: Int = 0
    //是否通过审核 0:未通过；1：通过
    var customer_id: Int = 0
    //客户id
    var vehicle_id: Int = 0
    //车辆id
    var whetherDefault: Int = 0
    //是否默认车辆
    required init() {}
}

// 客户对象
class Customer: HandyJSON {
    var customer_id: Int = 0
    //客户id
    var mobile: String?
    //手机号
    var shareCode: String?
    //分享码
    var customer_name: String?
    //客户名称
    var pwd: String?
    //密码
    var customer_VIP_level: String?
    //VIP等级
    var balance: Int = 0
    //账户余额
    var freezingAmount: Int = 0
    //冻结金额
    var delete_status: Int = 0
    //逻辑删除状态 0：未删除；1：已删除
    var delete_reason: String?
    //账户注销原因
    var invite_code: String?
    //邀请码
    var score: Int = 0
    //积分
    
    required init() {}
}


// 开单模块 订单对象
class MyOrderListModel: HandyJSON {
    
    var code: Int = 0
    var message: String?
    var data: [MyOrderModel] = [MyOrderModel]()
    required init() {}
}

class MyOrderModel: HandyJSON {
    var order_id: String?
    //订单id
    var customer_id: String?
    //客户id
    var shipper_mobile: String?
    //货主联系方式
    var shipper_SMS_reminder: String?
    //货主短信提醒，0：不提醒；1：开启短信提醒
    var deliverGoods_address: String?
    //发货地址
    var deliverLat: String?
    //发货地点经度
    var deliverLon: String?
    //发货地点纬度
    var deliverGoods_mobile: String?
    //发货人联系方式
    var deliverGoods_SMS_reminder: String?
    //发货短信提醒，0：不提醒；1：开启短信提醒
    var receivingGoods_address: String?
    //收货地址
    var receivingLon: String?
    //收货地点经度
    var receivingLat: String?
    //收货地点纬度
    var receivingGoods_mobile: String?
    //收货人联系方式
    var recervingGoods_SMS_reminder: String?
    //收货短信提醒，0：未开启；1：开启短信提醒
    var goods_packingType: String?
    //货物包装方式
    var min_goods_weight: String?
    //最小货物重量
    var max_goods_weight: String?
    //最大货物重量
    var goods_weight_units: String?
    //货物重量单位
    var min_goods_volume: String?
    //最小货物体积
    var max_goods_volume: String?
    //最大货物体积
    var goods_volume_units: String?
    //货物体积单位
    var goods_name: String?
    //货物名称
    var goods_type: String?
    //货物类型
    var service_requirements: String?
    //服务要求
    var frontMoney: String?
    //定金
    var hopeFreight: String?
    //期望运费
    var hopeFreight_units: String?
    //期望费用单位
    var freight: String?
    //费用（运费）
    var loadingDate: String?
    //装货时间：今天、明天、明天以后
    var loadingType: String?
    //装卸方式
    var order_type: String?
    //1:实时订单；2：定制订单；3：车队订单
    var vehicle_length: String?
    //车长
    var vehicle_type: String?
    //车辆类型
    var vehicleGroupOrDriverId: String?
    //当order_type为2时，这里存的是driverid；当order type为3时，这里是vehiclegroupid
    var createOrderTime: String?
    //订单生成时间
    var acceptOrderTime: String?
    //接单时间
    var order_status: String?
    //订单状态
    var whetherTopOrder: String?
    //是否常发货源 0：不是；1：是
    var distance: String?
    //距离，用于距离排序
    var driver_headImage_url: String?
    //司机头像
    var driver_name: String?
    //司机姓名
    var driver_mobile: String?
    //司机电话
    var receiptCustomer_id: String?
    //接单司机id
    var serverFreight: String?
    //服务费
    var unloadingTime: String?
    //卸货时间
    var agreement_weight: String?
    //协议里确定的重量
    var agreement_volume: String?
    //协议里确定的体积
    var agreement_vehicleNum: String?
    //协议里承运车牌号
    var remark: String?
    //备注
    var transport_time: String?
    //协议里运输时间
    var payFreightDays: String?
    //协议里最晚付清运费天数
    var commission: String?
    //佣金
    var orderName: String?
    // 线路名称
    var orderContent: String?
    // 订单内容
    var orderTime: String?
    // 订单生成时间
    
    required init() {}
}



// 开单模块 常用联系人列表对象
class TopContactsListModel: HandyJSON {
    
    var code: Int = 0
    var message: String?
    var data: [TopContactModel] = [TopContactModel]()
    required init() {}
}

// 开单模块 添加联系人
class AddContactsModel: HandyJSON {
    
    var code: Int = 0
    var message: String?
    var data: AddStatusModel?
    required init() {}
}

// 开单模块 修改联系人
class UpdateContactsModel: HandyJSON {
    
    var code: Int = 0
    var message: String?
    var data: AddStatusModel?
    required init() {}
}


// 开单模块 修改联系人
class DeleteTopContactsModel: HandyJSON {
    
    var code: Int = 0
    var message: String?
    var data: AddStatusModel?
    required init() {}
}


class AddStatusModel: HandyJSON {
    var data: Int = 0
    required init() {}
}


// 常用联系人对象
class TopContactModel: HandyJSON {
    var topContacts_id: String?
    //常用联系人id
    var customer_id: String?
    //客户id
    var topContacts_name: String?
    //姓名
    var topContacts_companyName: String?
    //公司
    var topContacts_mobile: String?
    //手机
    var topContacts_address: String?
    //地址
    var filed_name: String?
    //场名
    var filed_mobile: String?
    //场地联系方式
    var filed_remark: String?
    //场地备注
    var topContacts_lat: String?
    //常用联系人公司地址纬度
    var topContacts_lon: String?
    //常用联系人公司地址经度
    
    required init() {}
}

// 开单模块 货物类型列表对象
class GoodsTypeListModel: HandyJSON {
    
    var code: Int = 0
    var message: String?
    var data: [GoodsModel] = [GoodsModel]()
    required init() {}
}

// 货物类型对象
class GoodsModel: HandyJSON {
    var goods_id: String?
    // 货物id
    var goods_ParentId: String?
    
    // 货物父id
    var goods_name: String?
     
    //  货物名称
    var supportPackingType: String?
    // 支持的包装方式
    
    required init() {}
}

// 开单模块 货物名称列表对象
class GoodsListModel: HandyJSON {
    
    var code: Int = 0
    var message: String?
    var data: [GoodsModel] = [GoodsModel]()
    required init() {}
}
