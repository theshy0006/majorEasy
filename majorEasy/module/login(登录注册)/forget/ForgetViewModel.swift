//
//  ForgetViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/28.
//

import Foundation

class ForgetViewModel: NBViewModel {
    //注册
    var resetModel = ResetPasswordModel()
    
    //验证码
    var dataModel = ResetCode()
    
    //获取短信验证码（）
    func getSmsCode(mobile: String,
                  success: ((ResetCode)->())?,
                  failure: ((APIError)->())?) {
        dataModel.sendResetCode(mobile: mobile).subscribe(onNext: { model in
            if let suc = success {
                suc(model)
            }
        }, onError: { (error) in
            if let fail = failure, let err = error as? APIError {
                fail(err)
            }
        }).disposed(by: disposeBag)
    }
    
    func resetPassword(mobile: String,
                 Invite_code: String,
                 smsCode: String,
                  success: ((ResetPasswordModel)->())?,
                  failure: ((APIError)->())?) {
        
        resetModel.resetPassword(mobile: mobile, Invite_code: Invite_code, smsCode: smsCode).subscribe(onNext: { model in
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
