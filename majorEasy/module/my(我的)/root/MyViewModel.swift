//
//  MyViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/1.
//

import UIKit

class MyViewModel: NBViewModel {
    
    //单独的用户信息接口
    var myModel = MyModel()
    
    //登录接口
    func getUserInfo(
                  success: (()->())?,
                  failure: ((APIError)->())?) {
        myModel.getUserInfo().subscribe(onNext: { model in
            if let suc = success {
                DataCenterManager.default.myInfo = model.value
                suc()
            }
        }, onError: { (error) in
            if let fail = failure, let err = error as? APIError {
                fail(err)
            }
        }).disposed(by: disposeBag)
    }
}
