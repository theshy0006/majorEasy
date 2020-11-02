//
//  HandyJSON_Func.swift
//  yunyou
//
//  Created by wangyang on 2020/4/8.
//  Copyright © 2020 com.boc. All rights reserved.
//

import Foundation
import HandyJSON
import RxSwift

// 获取注册短信验证码
extension RegisterCode {
    func sendRegisterCode(mobile: String) -> Observable<RegisterCode> {
        return RxHttpManager.fetchData(with: URL_SendRegisterSmsCode+mobile,
                                       method: .get,
                                       parameters: nil,
                                       headers: ConstructHeaders(nil),
                                       returnType: RegisterCode.self).map({ (response: RegisterCode) -> RegisterCode in
            return response
        })
    }
}

// 获取重置短信验证码
extension ResetCode {
    func sendResetCode(mobile: String) -> Observable<ResetCode> {
        return RxHttpManager.fetchData(with: URL_SendResetSmsCode+mobile,
                                       method: .get,
                                       parameters: nil,
                                       headers: ConstructHeaders(nil),
                                       returnType: ResetCode.self).map({ (response: ResetCode) -> ResetCode in
            return response
        })
    }
}

// 登录接口主交易
extension LoginModel {
    
    func login(mobile: String, smsCode: String) -> Observable<LoginModel> {
        return RxHttpManager.fetchData(with: URL_Login,
                                       method: .post,
                                       parameters: [
                                        "loginKey":mobile,
                                        "loginPassword":smsCode
                                       ],
                                       headers: ConstructHeaders(nil),
                                       returnType: LoginModel.self).map({ (response: LoginModel) -> LoginModel in
            return response
        })
    }
}

// 注册接口主交易
extension RegisterModel {
    
    func register(mobile: String, Invite_code: String, smsCode: String, userRole: Int) -> Observable<RegisterModel> {
        return RxHttpManager.fetchData(with: URL_Register,
                                       method: .post,
                                       parameters: [
                                       "phoneNumber":mobile,
                                       "password":Invite_code,
                                       "verifyCode":smsCode,
                                       "userRole":userRole],
                                       headers: ConstructHeaders(nil),
                                       returnType: RegisterModel.self).map({ (response: RegisterModel) -> RegisterModel in
            return response
        })
    }
}

// 重置登录密码
extension ResetPasswordModel {
    
    func resetPassword(mobile: String, Invite_code: String, smsCode: String) -> Observable<ResetPasswordModel> {
        return RxHttpManager.fetchData(with: URL_ResetPassword,
                                       method: .post,
                                       parameters: [
                                       "phoneNumber":mobile,
                                       "passWord":Invite_code,
                                       "verifyCode":smsCode],
                                       headers: ConstructHeaders(nil),
                                       returnType: ResetPasswordModel.self).map({ (response: ResetPasswordModel) -> ResetPasswordModel in
            return response
        })
    }
}

// 获取首页轮播图
extension HomeImagesModel {
    
    func getHomeImages() -> Observable<HomeImagesModel> {
        return RxHttpManager.fetchData(with: URL_GetHomeImages,
                                       method: .get,
                                       parameters: nil,
                                       headers: ConstructHeaders(nil),
                                       returnType: HomeImagesModel.self).map({ (response: HomeImagesModel) -> HomeImagesModel in
            return response
        })
    }
}

// 获取首页轮播图
extension OrderModel {
    
    func getMyAppOrders(pageNum: Int, pageSize: Int, state: Int) -> Observable<OrderModel> {
        return RxHttpManager.fetchData(with: URL_GetMyAppOrders,
                                       method: .post,
                                       parameters: [
                                       "pageNum":pageNum,
                                       "pageSize":pageSize,
                                       "state":state],
                                       headers: ConstructHeaders(nil),
                                       returnType: OrderModel.self).map({ (response: OrderModel) -> OrderModel in
            return response
        })
    }
}

// 获取首页轮播图
extension MyModel {
    
    func getUserInfo() -> Observable<MyModel> {
        return RxHttpManager.fetchData(with: URL_GetUserInfo,
                                       method: .get,
                                       parameters: nil,
                                       headers: ConstructHeaders(nil),
                                       returnType: MyModel.self).map({ (response: MyModel) -> MyModel in
            return response
        })
    }
}

// 添加熟车
extension AddMyFamiliarVehicleModel {
    func addMyFamiliarVehicle(vehicle: String) -> Observable<AddMyFamiliarVehicleModel> {
        return RxHttpManager.fetchData(with: URL_AddMyFamiliarVehicle + vehicle ,
                                       method: .get,
                                       parameters: nil,
                                       headers: ConstructHeaders(nil),
                                       returnType: AddMyFamiliarVehicleModel.self).map({ (response: AddMyFamiliarVehicleModel) -> AddMyFamiliarVehicleModel in
            return response
        })
    }
}

// 获取消费记录
extension AccountRecordModel {
    func getAccountRecord() -> Observable<AccountRecordModel> {
        return RxHttpManager.fetchData(with: URL_GetAccountRecord,
                                       method: .post,
                                       parameters: nil,
                                       headers: ConstructHeaders(nil),
                                       returnType: AccountRecordModel.self).map({ (response: AccountRecordModel) -> AccountRecordModel in
            return response
        })
    }
}
// 获取专线列表
extension DedicatedLinesModel {
    func getDedicatedLines(loadPlaceCode: String, unloadPlaceCode: String, pageNum: Int, pageSize: Int, location: String) -> Observable<DedicatedLinesModel> {
        return RxHttpManager.fetchData(with: URL_GetDedicatedLines,
                                       method: .post,
                                       parameters: [
                                        "loadPlaceCode":"",
                                        "unloadPlaceCode":"",
                                        "pageNum":pageNum,
                                        "pageSize":pageSize,
                                        "location":location],
                                       headers: ConstructHeaders(nil),
                                       returnType: DedicatedLinesModel.self).map({ (response: DedicatedLinesModel) -> DedicatedLinesModel in
            return response
        })
    }
}

// 获取专线详情
extension DedicatedLineDetailModel {
    func getDedicatedLineDetail(lineId: String) -> Observable<DedicatedLineDetailModel> {
        return RxHttpManager.fetchData(with: URL_GetDedicatedLineDetail + lineId,
                                       method: .get,
                                       parameters: nil,
                                       headers: ConstructHeaders(nil),
                                       returnType: DedicatedLineDetailModel.self).map({ (response: DedicatedLineDetailModel) -> DedicatedLineDetailModel in
            return response
        })
    }
}

//获取我的货源列表

extension MySuppliesModel {
    //sortType:发货中与历史货源传1，常发传3
    //app
    func getMySuppliesModel(pageNum: Int, pageSize: Int, sortType: String, appSupplyStatus: String) -> Observable<MySuppliesModel> {
        return RxHttpManager.fetchData(with: URL_getMySupplies,
                                       method: .post,
                                       parameters: [
                                        "appSupplyStatus":appSupplyStatus,
                                        "sortType":sortType,
                                        "pageNum":pageNum,
                                        "pageSize":pageSize,
                                        "location":""],
                                       headers: ConstructHeaders(nil),
                                       returnType: MySuppliesModel.self).map({ (response: MySuppliesModel) -> MySuppliesModel in
            return response
        })
    }
}

// 删除货源
extension DeleteModel {
    func deleteMySupplies(supplyNum: String) -> Observable<DeleteModel> {
        return RxHttpManager.fetchData(with: URL_deletMysupply + supplyNum,
                                       method: .get,
                                       parameters: nil,
                                       headers: ConstructHeaders(nil),
                                       returnType: DeleteModel.self).map({ (response: DeleteModel) -> DeleteModel in
            return response
        })
    }
}

// 获取所有货源
extension AllSuppliesModel {
    func getSuppliesByParam(pageNum: Int, pageSize: Int, sortType: Int) -> Observable<AllSuppliesModel> {
        
        
        var latitude = 0.0
        var long = 0.0
        if let location = BaiduMapManager.shared().userLocation.location {
            latitude = location.coordinate.latitude
            long = location.coordinate.longitude
        }
        var location = ""
        if( latitude < 1.0 || long < 1.0 ) {
            
        } else {
            location = "\(latitude)" + "," + "\(long)"
        }
        
        
        return RxHttpManager.fetchData(with: URL_GetSuppliesByParam,
                                       method: .post,
                                       parameters: [
                                        "location":location,
                                        "sortType":sortType,
                                        "pageNum":pageNum,
                                        "pageSize":pageSize,
                                       ],
                                       headers: ConstructHeaders(nil),
                                       returnType: AllSuppliesModel.self).map({ (response: AllSuppliesModel) -> AllSuppliesModel in
            return response
        })
    }}

extension SaveUserInfo {
    func save(headPortraitKey: String, userName: String, emailAddress: String) -> Observable<SaveUserInfo> {
        
        return RxHttpManager.fetchData(with: URL_SaveUserInfo,
                                       method: .post,
                                       parameters: [
                                        "headPortraitKey":headPortraitKey,
                                        "userName":userName,
                                        "emailAddress":emailAddress
                                       ],
                                       headers: ConstructHeaders(nil),
                                       returnType: SaveUserInfo.self).map({ (response: SaveUserInfo) -> SaveUserInfo in
            return response
        })
    }
    
}


// 获取车源列表
extension CarModel {
    //sortCode:1 代表默认排序 :2 距离排序
    func getAllvehicles(pageNum: Int, pageSize: Int, sortCode: Int) -> Observable<CarModel> {
        var latitude = 0.0
        var long = 0.0
        if let location = BaiduMapManager.shared().userLocation.location {
            latitude = location.coordinate.latitude
            long = location.coordinate.longitude
        }
        
        
        
        return RxHttpManager.fetchData(with: URL_GetAllvehicles,
                                       method: .post,
                                       parameters: [
                                        "pointLat":latitude,
                                        "pointLon":long,
                                        "sortCode":sortCode,
                                        "pageNum":pageNum,
                                        "pageSize":pageSize,
                                       ],
                                       headers: ConstructHeaders(nil),
                                       returnType: CarModel.self).map({ (response: CarModel) -> CarModel in
            return response
        })
    }
    
    func getMyFamiliarVehicles(pageNum: Int, pageSize: Int, departurePlaceCode: String) -> Observable<CarModel> {
        return RxHttpManager.fetchData(with: URL_GetMyFamiliarVehicles,
                                       method: .post,
                                       parameters: [
                                        "departurePlaceCode":departurePlaceCode,
                                        "pageNum":pageNum,
                                        "pageSize":pageSize,
                                       ],
                                       headers: ConstructHeaders(nil),
                                       returnType: CarModel.self).map({ (response: CarModel) -> CarModel in
            return response
        })
    }
}

extension UploadImageModel {
    func uploadImage(image: UIImage) -> Observable<UploadImageModel> {
        return RxHttpManager.fetchFormData(with: URL_Uploadheadportrait,
                                       method: .post,
                                       image: image,
                                       headers: ConstructHeaders(nil),
                                       returnType: UploadImageModel.self).map({ (response: UploadImageModel) -> UploadImageModel in
            return response
        })
    }
    
    func uploadFrontImage(image: UIImage) -> Observable<UploadImageModel> {
        return RxHttpManager.fetchFormData(with: URL_UploadIdCardFront,
                                       method: .post,
                                       image: image,
                                       headers: ConstructHeaders(nil),
                                       returnType: UploadImageModel.self).map({ (response: UploadImageModel) -> UploadImageModel in
            return response
        })
    }
    
    func uploadBackImage(image: UIImage) -> Observable<UploadImageModel> {
        return RxHttpManager.fetchFormData(with: URL_UploadIdCardReverse,
                                       method: .post,
                                       image: image,
                                       headers: ConstructHeaders(nil),
                                       returnType: UploadImageModel.self).map({ (response: UploadImageModel) -> UploadImageModel in
            return response
        })
    }
}

extension SubUserReviewModel {
    func subUserReview(userRealName: String, idCardNumber: String, idCardFrontImgKey: String, idCardReverseImgKey: String) -> Observable<SubUserReviewModel> {
        return RxHttpManager.fetchData(with: URL_SubUserReview,
                                       method: .post,
                                       parameters: [
                                        "userRealName":userRealName,
                                        "idCardNumber":idCardNumber,
                                        "idCardFrontImgKey":idCardFrontImgKey,
                                        "idCardReverseImgKey":idCardReverseImgKey
                                       ],
                                       headers: ConstructHeaders(nil),
                                       returnType: SubUserReviewModel.self).map({ (response: SubUserReviewModel) -> SubUserReviewModel in
            return response
        })
    }
}

extension IntegralModel {
    func getIntegral(pageNum: Int, pageSize: Int, rank: Int) -> Observable<IntegralModel> {
        return RxHttpManager.fetchData(with: URL_GetIntegralRankList,
                                       method: .post,
                                       parameters: [
                                       "pageNum":pageNum,
                                       "pageSize":pageSize,
                                       "rank":rank],
                                       headers: ConstructHeaders(nil),
                                       returnType: IntegralModel.self).map({ (response: IntegralModel) -> IntegralModel in
            return response
        })
    }
}

extension RechargeModel {
    func getRecharge(pageNum: Int, pageSize: Int, rank: Int) -> Observable<RechargeModel> {
        return RxHttpManager.fetchData(with: URL_GetRechargeRankList,
                                       method: .post,
                                       parameters: [
                                       "pageNum":pageNum,
                                       "pageSize":pageSize,
                                       "rank":rank],
                                       headers: ConstructHeaders(nil),
                                       returnType: RechargeModel.self).map({ (response: RechargeModel) -> RechargeModel in
            return response
        })
    }
}

extension InviteModel {
    func getInvite(pageNum: Int, pageSize: Int, rank: Int) -> Observable<InviteModel> {
        return RxHttpManager.fetchData(with: URL_GetInviteRankList,
                                       method: .post,
                                       parameters: [
                                       "pageNum":pageNum,
                                       "pageSize":pageSize,
                                       "rank":rank],
                                       headers: ConstructHeaders(nil),
                                       returnType: InviteModel.self).map({ (response: InviteModel) -> InviteModel in
            return response
        })
    }
}

extension ShareModel {
    func getShareUrl() -> Observable<ShareModel> {
        return RxHttpManager.fetchData(with: URL_GetMyShareUrl,
                                       method: .get,
                                       parameters: nil,
                                       headers: ConstructHeaders(nil),
                                       returnType: ShareModel.self).map({ (response: ShareModel) -> ShareModel in
            return response
        })
    }
}

extension BillModel {
    func getBill(pageNum: Int, pageSize: Int) -> Observable<BillModel> {
        return RxHttpManager.fetchData(with: URL_GetRecords,
                                       method: .post,
                                       parameters: [
                                       "pageNum":pageNum,
                                       "pageSize":pageSize],
                                       headers: ConstructHeaders(nil),
                                       returnType: BillModel.self).map({ (response: BillModel) -> BillModel in
            return response
        })
    }
}

extension RechargeListModel {
    func getRecharge(pageNum: Int, pageSize: Int) -> Observable<RechargeListModel> {
        return RxHttpManager.fetchData(with: URL_GetRechargeRecord,
                                       method: .post,
                                       parameters: [
                                       "pageNum":pageNum,
                                       "pageSize":pageSize],
                                       headers: ConstructHeaders(nil),
                                       returnType: RechargeListModel.self).map({ (response: RechargeListModel) -> RechargeListModel in
            return response
        })
    }
}

extension WithDrawModel {
    func getWithDraw(pageNum: Int, pageSize: Int) -> Observable<WithDrawModel> {
        return RxHttpManager.fetchData(with: URL_GetWithdrawalRecord,
                                       method: .post,
                                       parameters: [
                                       "pageNum":pageNum,
                                       "pageSize":pageSize],
                                       headers: ConstructHeaders(nil),
                                       returnType: WithDrawModel.self).map({ (response: WithDrawModel) -> WithDrawModel in
            return response
        })
    }
}

extension SendGoodsModel {
    func send(model: MySuppliesInfo, deliveryDataApp: String, arrivalDataApp: String) -> Observable<SendGoodsModel> {
        return RxHttpManager.fetchData(with: URL_SendGoods,
                                       method: .post,
                                       parameters: [
                                        "loadPlace":model.loadPlace ?? "",
                                        "loadPlaceCode":model.loadPlaceCode ?? "",
                                        "loadPlaceDetail":model.loadPlaceDetail ?? "",
                                        "unloadPlace":model.unloadPlace ?? "",
                                        "unloadPlaceCode":model.unloadPlaceCode ?? "",
                                        "unloadPlaceDetail":model.unloadPlaceDetail ?? "",
                                        "useMode":model.useMode ?? "",
                                        "vehicleType":model.vehicleType ?? "",
                                        "vehicleLength":model.vehicleLength ?? "",
                                        "vehicleHeight":model.vehicleHeight ?? "",
                                        "goodsName":model.goodsName ?? "",
                                        "goodsType":model.goodsType ?? "",
                                        "goodsWeight_lower":model.goodsWeight_lower,
                                        "goodsWeight_upper":model.goodsWeight_upper,
                                        "goodsVolume_lower":model.goodsVolume_lower,
                                        "goodsVolume_upper":model.goodsVolume_upper,
                                        "goodsLength":model.goodsLength,
                                        "goodsWide":model.goodsWide,
                                        "goodsHeight":model.goodsHeight,
                                        "goodsDiameter":model.goodsDiameter,
                                        "goodsRemarks":model.goodsRemarks ?? "",
                                        "packType":model.packType ?? "",
                                        "loadMode":model.loadMode ?? 1,
                                        "purposePrice":model.purposePrice,
                                        "contactNum":model.contactNum ?? "",
                                        "deliveryDataApp":deliveryDataApp,
                                        "deliveryTime":model.deliveryTime ?? "",
                                        "arrivalDataApp":arrivalDataApp,
                                        "arrivalTime":model.arrivalTime ?? "",
                                        "remarks":model.remarks ?? "",
                                        "carrierId":model.carrierId,
                                        "carrierPhone":model.carrierPhone ?? "",
                                       ],
                                       headers: ConstructHeaders(nil),
                                       returnType: SendGoodsModel.self).map({ (response: SendGoodsModel) -> SendGoodsModel in
            return response
        })
    }
}

extension QueryPriceModel {
    func query(model: MySuppliesInfo) -> Observable<QueryPriceModel> {
        return RxHttpManager.fetchData(with: URL_GetReferencePrice,
                                       method: .post,
                                       parameters: [
                                        "loadPlace":model.loadPlace ?? "",
                                        "loadPlaceCode":model.loadPlaceCode ?? "",
                                        "loadPlaceDetail":model.loadPlaceDetail ?? "",
                                        "unloadPlace":model.unloadPlace ?? "",
                                        "unloadPlaceCode":model.unloadPlaceCode ?? "",
                                        "unloadPlaceDetail":model.unloadPlaceDetail ?? "",
                                        "goodsName":model.goodsName ?? "",
                                        "goodsType":model.goodsType ?? "",
                                        "goodsWeight_lower":model.goodsWeight_lower,
                                        "goodsWeight_upper":model.goodsWeight_upper,
                                        "goodsVolume_lower":model.goodsVolume_lower,
                                        "goodsVolume_upper":model.goodsVolume_upper,
                                        "goodsLength":model.goodsLength,
                                        "goodsWide":model.goodsWide,
                                        "goodsHeight":model.goodsHeight,
                                        "goodsDiameter":model.goodsDiameter,
                                        "goodsRemarks":model.goodsRemarks ?? "",
                                       ],
                                       headers: ConstructHeaders(nil),
                                       returnType: QueryPriceModel.self).map({ (response: QueryPriceModel) -> QueryPriceModel in
            return response
        })
    }
}

// 查询指派人
extension SearchCarrierModel {
    func searchCarrier(mobile: String) -> Observable<SearchCarrierModel> {
        return RxHttpManager.fetchData(with: URL_SearchCarrier+mobile,
                                       method: .get,
                                       parameters: nil,
                                       headers: ConstructHeaders(nil),
                                       returnType: SearchCarrierModel.self).map({ (response: SearchCarrierModel) -> SearchCarrierModel in
            return response
        })
    }
}

extension FinishOrderModel {
    func finishOrder(orderNum: String) -> Observable<FinishOrderModel> {
        return RxHttpManager.fetchData(with: URL_FinishOrder+orderNum,
                                       method: .get,
                                       parameters: nil,
                                       headers: ConstructHeaders(nil),
                                       returnType: FinishOrderModel.self).map({ (response: FinishOrderModel) -> FinishOrderModel in
            return response
        })
    }
}

extension CancleOrderModel {
    func cancleOrder(orderNum: String) -> Observable<CancleOrderModel> {
        return RxHttpManager.fetchData(with: URL_CancleOrder,
                                       method: .post,
                                       parameters: [
                                        "orderNum":orderNum
                                       ],
                                       headers: ConstructHeaders(nil),
                                       returnType: CancleOrderModel.self).map({ (response: CancleOrderModel) -> CancleOrderModel in
            return response
        })
    }
}

