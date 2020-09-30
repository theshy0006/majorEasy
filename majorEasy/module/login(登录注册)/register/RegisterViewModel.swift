//
//  RegisterViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/27.
//

import Foundation

class RegisterViewModel: NBViewModel {
    //注册
    var registerModel = RegisterModel()
    
    //验证码
    var dataModel = RegisterCode()
    
    
    
    //获取短信验证码（）
    func getSmsCode(mobile: String,
                  success: ((RegisterCode)->())?,
                  failure: ((APIError)->())?) {
        dataModel.sendRegisterCode(mobile: mobile).subscribe(onNext: { model in
            if let suc = success {
                suc(model)
            }
        }, onError: { (error) in
            if let fail = failure, let err = error as? APIError {
                fail(err)
            }
        }).disposed(by: disposeBag)
    }
    
    func register(mobile: String,
                 Invite_code: String,
                 smsCode: String,
                 userRole: Int,
                  success: ((RegisterModel)->())?,
                  failure: ((APIError)->())?) {
        
        registerModel.register(mobile: mobile, Invite_code: Invite_code, smsCode: smsCode, userRole: userRole).subscribe(onNext: { model in
            if let suc = success {
                suc(model)
            }
        }, onError: { (error) in
            if let fail = failure, let err = error as? APIError {
                fail(err)
            }
        }).disposed(by: disposeBag)
    }
}
