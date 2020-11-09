//
//  RushHallViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/11/8.
//

import UIKit

class RushHallViewModel: NBViewModel {
    //单独的用户信息接口
    var myModel = MyModel()
    
    var certificateModel = CertificateModel()
    var dataSource:[CertificateItem] = []
    var subCertOrder = SubCertOrder()
    
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
    
    func getCertificate( success: (()->())?,
              failure: ((APIError)->())? ) {
        certificateModel.queryCertificate(province: "320000").subscribe(onNext: {[weak self] model in
            if let suc = success {
                self?.dataSource = model.value
                suc()
            }
        }, onError: { (error) in
            if let fail = failure, let err = error as? APIError {
                fail(err)
            }
        }).disposed(by: disposeBag)
    }
    
    
    
    func balanceMain(certId: Int, integral: Int, price: Int, paymentWay: Int, success: ((SubCertOrder)->())?,failure: ((APIError)->())? ) {
        subCertOrder.mainFunc(certId: certId, integral: integral, price: price, paymentWay: paymentWay).subscribe(onNext: { model in
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
