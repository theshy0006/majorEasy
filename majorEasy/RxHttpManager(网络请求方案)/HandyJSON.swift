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

// 登录后返回的部分用户信息
class UserInfo: HandyJSON {
    var token: String?
    var idReview: Int?
    var userRole: Int?
    var userRoleName: String?
    var userRealName: String?
    var phoneNumber: String?
    var vipLevel: Int?
    required init() {}
}

// 单独的用户信息接口
class MyModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: MyInfo = MyInfo()
    required init() {}
}

// 单独的用户信息接口
class MyInfo: HandyJSON {
    var id: Int = 0
    var phoneNumber: String?
    var userName: String?
    var userRealName: String?
    var emailAddress: String?
    var headPortraitKey: String?
    var headPortraitUrl: String?
    var integral:Float = 0.00
    var idReview: Int = 0
    var accountNum: String?
    var balance:Float = 0.00
    var rechargeReward:Float = 0.00
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


// 添加熟车返回对象
class AddMyFamiliarVehicleModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: String?
    required init() {}
}

// 添加熟车返回对象
class AccountRecordModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: [AccountRecordItem] = [AccountRecordItem]()
    required init() {}
}

// 添加熟车返回对象
class AccountRecordItem: HandyJSON {
    var id: Int = 0
    var orderNum: String?
    var recordTime: String?
    var recordType: Int = 0
    var amount: Float = 0.0
    var userId: Int = 0
    var payUserId: Int = 0
    var accountNum: String?
    var operation: String?
    var payUserRealName: String?
    var payPhoneNumber: String?
    var payUserShowName: String?
    required init() {}
}

// 专线列表返回对象
class DedicatedLinesModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: [DedicatedLinesItem] = [DedicatedLinesItem]()
    required init() {}
}

// 专线列表返回对象
class DedicatedLinesItem: HandyJSON {
    var addTime: String?
    var addUser: Int = 0
    var advertKey: String?
    var advertPics: [String]?
    var authentication: Bool = false
    var bubbleUnitPrice: Float = 0.0
    var companyAddress: String?
    var companyLocation: String?
    var companyName: String?
    var companyWebAddress: String?
    var contactMobile: String?
    var contactTelephone: String?
    var contactUser: String?
    var dedicatedLineBranches: [String]?
    var dedicatedLineNum: String?
    var distance: Float = 0.0
    var enable: Bool = false
    var heavyUnitPrice: Float = 0.0
    var id: Int = 0
    var introduce: String?
    var loadPlace: String?
    var loadPlaceCode: String?
    var logoKey: String?
    var logoPic: String?
    var tags: String?
    var transportDays: Int = 0
    var unloadPlace: String?
    var unloadPlaceCode: String?
    var views: Int = 0
    var wxAccount: String?
    required init() {}
}

// 我的专线列表返回对象
class MyDedicatedLinesModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: [MyDedicatedLinesItem] = [MyDedicatedLinesItem]()
    required init() {}
}

// 我的专线列表返回对象
class MyDedicatedLinesItem: HandyJSON {
    var addTime: String?
    var addUser: Int = 0
    var advertKey: String?
    var advertPics: [String]?
    var authentication: Bool = false
    var bubbleUnitPrice: Float = 0.0
    var companyAddress: String?
    var companyLocation: String?
    var companyName: String?
    var companyWebAddress: String?
    var contactMobile: String?
    var contactTelephone: String?
    var contactUser: String?
    var dedicatedLineBranches: [String]?
    var dedicatedLineNum: String?
    var distance: Float = 0.0
    var enable: Bool = false
    var heavyUnitPrice: Float = 0.0
    var id: Int = 0
    var introduce: String?
    var loadPlace: String?
    var loadPlaceCode: String?
    var logoKey: String?
    var logoPic: String?
    var tags: String?
    var transportDays: Int = 0
    var unloadPlace: String?
    var unloadPlaceCode: String?
    var views: Int = 0
    var wxAccount: String?
    required init() {}
}

// 专线详情
class DedicatedLineDetailModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: DedicatedLineDetailInfo = DedicatedLineDetailInfo()
    required init() {}
}

// 专线详情
class DedicatedLineDetailInfo: HandyJSON {
    var dedicatedLineNum: String?
    var loadPlace: String?
    var loadPlaceCode: String?
    var unloadPlace: String?
    var unloadPlaceCode: String?
    var transportDays: Int = 0
    var bubbleUnitPrice: Float = 0
    var heavyUnitPrice: Float = 0
    var contactUser: String?
    var contactMobile: String?
    var contactTelephone: String?
    var companyName: String?
    var companyAddress: String?
    var companyWebAddress: String?
    var wxAccount: String?
    var businessCardKey: String?
    var advertKey: String?
    var introduce: String?
    var addTime: String?
    var addUser: String?
    var dedicatedLineBranches: [String]?
    var logoPic: String?
    var advertPics: [String]?
    required init() {}
}

// 我的货源列表
class MySuppliesModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: [MySuppliesInfo] = [MySuppliesInfo]()
    required init() {}
}

//所有货源列表
class AllSuppliesModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: AllSuppliesItemModel = AllSuppliesItemModel()
    required init() {}
}

class AllSuppliesItemModel: HandyJSON {
    var list: [MySuppliesInfo] = [MySuppliesInfo]()
    required init() {}
}

// 我的货源项
class MySuppliesInfo: HandyJSON {
    var arrivalData: String?
    var arrivalTime: String?
    var companyName: String?
    var contactNum: String?
    var deliverTimeMsg: String?
    var deliveryData: String?
    var deliveryTime: String?
    var distance: Float = 0
    var enabled: Bool = false
    var goodsDiameter: Float = 0
    var goodsHeight: Float = 0
    var goodsLength: Float = 0
    var goodsName: String?
    var goodsRemarks: String?
    var goodsType: String?
    var goodsVolume: String?
    var goodsVolume_lower: Float = 0
    var goodsVolume_upper: Float = 0
    var goodsWeight: String?
    var goodsWeight_lower: Float = 0
    var goodsWeight_upper: Float = 0
    var goodsWide: Float = 0
    var haveContacted: Int = 0
    var headPortraitKey: String?
    var headPortraitUrl: String?
    var id: Int = 0
    var loadMode: Int = 0
    var loadModeId: Int = 0
    var loadPlace: String?
    var loadPlaceCity: String?
    var loadPlaceCode: String?
    var loadPlaceDetail: String?
    var loadPlaceDistance: Int = 0
    var loadPlaceLocation: String?
    var loadPlaceShow: String?
    var mySupplyMsg: String?
    var packType: String?
    var phoneNumber: String?
    var purposePrice: Float = 0
    var referencePrice: Float = 0
    var releaseFrequency: Int = 0
    var releaseNum: Int = 0
    var releaseTime: String?
    var remarks: String?
    var state: Int = 0
    var supplyNum: String?
    var supplyViews: Int = 0
    var timeAgo: String?
    var transactionNum: Int = 0
    var unloadPlace: String?
    var unloadPlaceCity: String?
    var unloadPlaceCode: String?
    var unloadPlaceDetail: String?
    var unloadPlaceShow: String?
    var useMode: String?
    var userName: String?
    var userRealName: String?
    var userid: Int = 0
    var vehicleHeight: String?
    var vehicleLength: String?
    var vehicleType: String?
    var vehicleTypeId: String?
    var carrierId: Int = 0
    var carrierPhone: String?
    required init() {}
}

// 删除货源
class DeleteModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: String?
    required init() {}
}

//车源列表
class CarModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: CarItemModel = CarItemModel()
    required init() {}
}

class CarItemModel: HandyJSON {
    var list: [CarInfo] = [CarInfo]()
    required init() {}
}


//车源列表对应的车源项
class CarInfo: HandyJSON {
    var bankCardNum: String?
    var cooperationTimes: Int = 0
    var driverLicense: String?
    var headPortraitKey: String?
    var headPortraitUrl: String?
    var idReview: Int = 0
    var idcardNum: String?
    var ifFamilarVehicle: Bool = false
    var licenseNum: String?
    var locationAddress: String?
    var locationDistance: Float = 0
    var locationLat: String?
    var locationLon: String?
    var locationMsg: String?
    var locationTime: String?
    var locationUpdateTime: String?
    var ownerName: String?
    var ownerPhoneNum: String?
    var plateColor: String?
    var plateType: String?
    var proxyBankCardNum: String?
    var proxyName: String?
    var qualificationNum: String?
    var registUserId: Int = 0
    var registUserName: String?
    var registUserPhone: String?
    var registerTime: String?
    var regularRoutes: [String]?
    var regularRoutesMsg: String?
    var stagnationCity: String?
    var stagnationCityCode: String?
    var transportationPermits: String?
    var userEvaluateRate: String?
    var vehicleHeight: Float = 0
    var vehicleLength: Float = 0
    var vehicleLoad: Float = 0
    var vehicleNum: String?
    var vehicleReview: Int = 0
    var vehicleSort: String?
    var vehicleType: String?
    var vehicleTypeId: Int = 0
    required init() {}
}


// 图片上传对象对象
class UploadImageModel: HandyJSON {
    
    var status: Int = 0
    var message: String?
    var value: UploadImageItem = UploadImageItem()
    required init() {}
}

class UploadImageItem: HandyJSON {
    var imgkey: String?
    var imgurl: String?
    
    required init() {}
}

class SaveUserInfo: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: String?
    
    required init() {}
}

// 重置登录密码返回对象
class SubUserReviewModel: HandyJSON {
    
    var status: Int = 0
    var message: String?
    var value: String?

    required init() {}
}

// 奖励对象
class IntegralModel: HandyJSON {
    
    var status: Int = 0
    var message: String?
    var value: [TopTenItem] = [TopTenItem]()

    required init() {}
}

// 充值对象
class RechargeModel: HandyJSON {
    
    var status: Int = 0
    var message: String?
    var value: [TopTenItem] = [TopTenItem]()

    required init() {}
}

// 邀请对象
class InviteModel: HandyJSON {
    
    var status: Int = 0
    var message: String?
    var value: [TopTenItem] = [TopTenItem]()

    required init() {}
}

// 邀请对象
class TopTenItem: HandyJSON {
    
    var headPortraitKey: String?
    var headPortraitUrl: String?
    var id: Int = 0
    var inviteNums: Int = 0
    var phoneNumber: String?
    var sumIntegral: Int = 0
    var sumRecharge: Int = 0
    var userName: String?
    var userRealName: String?

    required init() {}
}

// 获取分享链接
class ShareModel: HandyJSON {
    
    var status: Int = 0
    var message: String?
    var value: String?

    required init() {}
}
// 账单列表
class BillModel: HandyJSON {
    
    var status: Int = 0
    var message: String?
    var value: [BillItem] = [BillItem]()

    required init() {}
}

class BillItem: HandyJSON {
    
    var amount: Float = 0.0
    var creatTime: String?
    var operation: String?
    var orderNum: String?
    var phoneNumber: String?
    var placeInfo: String?
    var recordTime: String?
    var type: Int = 0
    var userId: String?
    var userInfo: String?
    var userName: String?

    required init() {}
}
// 充值列表
class RechargeListModel: HandyJSON {
    
    var status: Int = 0
    var message: String?
    var value: RechargeListObj = RechargeListObj()
    required init() {}
}

class RechargeListObj: HandyJSON {
    var list: [RechargeListItem] = [RechargeListItem]()
    required init() {}
}

class RechargeListItem: HandyJSON {
    var accountNum: String?
    var amount: Float = 0.0
    var ifPay:Bool = false
    var phoneNumber: String?
    var rechargeNum: String?
    var rechargeReward: Int = 0
    var rechargeStatus: String?
    var rechargeTime: String?
    var rechargeType: Int = 0
    var rechargeTypeName: String?
    var userId: Int = 0
    var userRealName: String?
    
    required init() {}
}
// 提现选项
class WithDrawModel: HandyJSON {
    
    var status: Int = 0
    var message: String?
    var value: WithDrawObj = WithDrawObj()
    required init() {}
}

class WithDrawObj: HandyJSON {
    var list: [WithDrawItem] = [WithDrawItem]()
    required init() {}
}

class WithDrawItem: HandyJSON {
    var accountNum: String?
    var amount: Float = 0.0
    var bankCardId: Int = 0
    var bankName: String?
    var cardNumber: String?
    var cardType: String?
    var id: Int = 0
    var phoneNumber: String?
    var state: Int = 0
    var stateName: String?
    var userId: Int = 0
    var userRealName: String?
    var withdrawalTime: String?
    var withdrawalType: Int = 0
    var withdrawalTypeName: String?
    
    required init() {}
}

// 发货
class SendGoodsModel: HandyJSON {
    
    var status: Int = 0
    var message: String?
    var value: String?

    required init() {}
}

// 发货
class QueryPriceModel: HandyJSON {
    
    var status: Int = 0
    var message: String?
    var value: String?

    required init() {}
}

// 查询指派人
class SearchCarrierModel: HandyJSON {
    
    var status: Int = 0
    var message: String?
    var value: SearchCarrierItem = SearchCarrierItem()

    required init() {}
}

class SearchCarrierItem: HandyJSON {
    
    var carrierId: Int = 0
    var carrierName: String?
    var carrierPhone: String?

    required init() {}
}

// 完成订单
class FinishOrderModel: HandyJSON {
    
    var status: Int = 0
    var message: String?
    var value: String?

    required init() {}
}

// 取消订单
class CancleOrderModel: HandyJSON {
    
    var status: Int = 0
    var message: String?
    var value: String?

    required init() {}
}

// 添加通讯录
class AddAddress: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: String?
    required init() {}
}


// 证书类型
class CertificateModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: [CertificateItem] = [CertificateItem]()

    required init() {}
}

class CertificateItem: HandyJSON {
    var certName: String?
    var cityCode: String?
    var describe: String?
    var id: Int = 0
    var price: Int = 0
    var provinceCode: String?
    required init() {}
}

//证件办理主交易
class SubCertOrder: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: WeixinPay = WeixinPay()
    required init() {}
}

class WeixinPay: HandyJSON {
    var timestamp: String?
    var partnerid: String?
    var package: String?
    var noncestr: String?
    var sign: String?
    var appid: String?
    var prepayid: String?
    required init() {}
}

//临牌办理主交易
class SubTemLicenceOrder: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: WeixinPay = WeixinPay()
    required init() {}
}

// 报价列表对象
class QuoteModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: [QuoteItem] = [QuoteItem]()
    required init() {}
}

// 报价列表数据
class QuoteItem: HandyJSON {
    var loadPlaceShow: String?
    var unloadPlaceShow: String?
    var phoneNumber: String?
    var mySupplyMsg: String?
    var offerMsg: String?
    var offerTime: String?
    required init() {}
}

// 银行卡对象
class CardModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: [CardItem] = [CardItem]()
    required init() {}
}

class DeleteCardModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: String?
    required init() {}
}

// 银行卡对象
class CardItem: HandyJSON {
    var id: Int = 0
    var typeName: String?
    var bankName: String?
    var logoKey: String?
    var cardHolderName: String?
    var abbreviation: String?
    var accountNum: String?
    var cardNumber: String?
    var color: String?
    var logoUrl: String?
    var userId: Int = 0
    var cardType: Int = 0
    var bankId: Int = 0
    var phoneNumber: String?
    var logoUrlApp: String?
    
    required init() {}
}

// 银行对象
class BankModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: [BankItem] = [BankItem]()
    required init() {}
}

// 银行对象
class BankItem: HandyJSON {
    var abbreviation: String?
    var bankCode: String?
    var bankName: String?
    var color: String?
    var id: Int = 0
    var logoKey: String?
    var logoPic: String?
    
    required init() {}
}

// 银行对象
class BindBankModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: String?
    required init() {}
}

// 银行对象
class FlatbedHomePagePics: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: [String] = [String]()
    required init() {}
}

// 板车公司列表
class FlatbedCompanysModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: [FlatbedCompanysItem] = [FlatbedCompanysItem]()
    required init() {}
}

class FlatbedCompanysItem: HandyJSON {
    var companyLogoUrl: String?
    var companyName: String?
    var id: Int = 0
   
    required init() {}
}

// 二手车
class UsedVehicles: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: [UsedVehiclesItem] = [UsedVehiclesItem]()
    required init() {}
}

class UsedVehiclesItem: HandyJSON {
    var headBrandName: String?
    var head_horsepower: Float = 0
    var driveFormName: String?
    var flatbedBrandName: String?
    var flatbedTypeName: String?
    var flatbed_brand: Int = 0
    var flatbed_length: Float = 0
    var flatbed_registrationDate: String?
    var flatbed_type: Int = 0
    var flatbed_weightBearing: Int = 0
    var location: String?
    var locationDetial: String?
    var phoneNumber: String?
    var pictureUrl: [String]?
    var releaseTime: String?
    var releaseUser: Int = 0
    var remarks: String?
    var sellSeparately: Bool = false
    var standardName: String?
    var type: Int = 0
    var usedVehicleNum: String?
    var userRealName: String?
    var wishPrice: Float = 0
    required init() {}
}

// 求职列表
class DriverModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: DrivierTemp = DrivierTemp()
    required init() {}
}

class DrivierTemp: HandyJSON {
    var list: [DriverItem] = [DriverItem]()
    required init() {}
}

class DriverItem: HandyJSON {
    var age: Int = 0
    var driveAge: Int = 0
    var id: Int = 0
    var job: String?
    var name: String?
    var phoneNumber: String?
    var releaseTime: String?
    var releaseUser: Int = 0
    var releaseUserName: String?
    var releaseUserPhone: String?
    var remarks: String?
    var salary: String?
    var title: String?
    var workArea: String?
    var workAreaCode: String?
    required init() {}
}

// 招聘列表
class RecruitListModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: RecruitListItemModel = RecruitListItemModel()
    required init() {}
}

class RecruitListItemModel: HandyJSON {
    var list: [RecruitListItem] = [RecruitListItem]()
    required init() {}
}

class RecruitListItem: HandyJSON {
    var id: Int = 0
    var job: String?
    var name: String?
    var phoneNumber: String?
    var releaseTime: String?
    var releaseUser: Int = 0
    var releaseUserName: String?
    var releaseUserPhone: String?
    var remarks: String?
    var salary: String?
    var title: String?
    var vehicleType: String?
    var workArea: String?
    var workAreaCode: String?
    required init() {}
}

// 商城首页列表
class GoodsModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: [GoodsItem] = [GoodsItem]()
    required init() {}
}

class GoodsItem: HandyJSON {
    var describe: String?
    var goodsName: String?
    var id: String?
    var material: String?
    var picture: String?
    var pictureUrls: [String]?
    var price: String?
    var size: String?
    var title: String?
    
    required init() {}
}

class VersionCheckModel: HandyJSON {
    var status: Int = 0
    var message: String?
    var value: VersionCheckItem = VersionCheckItem()
    required init() {}
}

class VersionCheckItem: HandyJSON {
    var iosDescription: String?
    var iosVersionCode: String?
    var iosVersionName: String?
    required init() {}
}

