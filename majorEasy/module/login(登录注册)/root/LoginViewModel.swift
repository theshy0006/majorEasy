//
//  LoginViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/27.
//

import Foundation
import HandyJSON
import RxSwift
class LoginViewModel: NSObject {
    
    //登录
    var loginModel = LoginModel()
    
    
    let disposeBag = DisposeBag()

    //登录接口
    func loginIn(mobile: String,
                 smsCode: String,
                  success: ((LoginModel)->())?,
                  failure: ((APIError)->())?) {
        loginModel.login(mobile: mobile, smsCode: smsCode).subscribe(onNext: { model in
            if let suc = success {
                DataCenterManager.default.userInfo = model.value
                DataCenterManager.default.isLogin = true
                DataCenterManager.default.save()
                suc(model)
            }
        }, onError: { (error) in
            if let fail = failure, let err = error as? APIError {
                fail(err)
            }
        }).disposed(by: disposeBag)
    }
   
}
