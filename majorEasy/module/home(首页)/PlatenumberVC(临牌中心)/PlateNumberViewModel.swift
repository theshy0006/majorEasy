//
//  PlateNumberViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/11/8.
//

import UIKit

class PlateNumberViewModel: NBViewModel {
    //单独的用户信息接口
    var myModel = MyModel()

    var subTemLicenceModel = SubTemLicenceOrder()
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
    
    func main(temLicenceId: Int, price: Int, paymentWay: Int, success: ((SubTemLicenceOrder)->())?,failure: ((APIError)->())? ) {
        subTemLicenceModel.mainFunc(temLicenceId: temLicenceId, price: price, paymentWay: paymentWay).subscribe(onNext: { model in
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
