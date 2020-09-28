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

