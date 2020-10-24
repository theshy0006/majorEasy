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

