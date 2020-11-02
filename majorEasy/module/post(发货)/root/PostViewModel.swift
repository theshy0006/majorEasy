//
//  PostViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/28.
//

import UIKit

class PostViewModel: NBViewModel {
    //登录
    var sendModel = SendGoodsModel()
    var queryPriceModel = QueryPriceModel()
    var mySuppliesInfo = MySuppliesInfo()
    var searchModel = SearchCarrierModel()
    //登录接口
    func send(deliveryDataApp: String,
              arrivalDataApp: String,
                  success: ((SendGoodsModel)->())?,
                  failure: ((APIError)->())?) {
        sendModel.send(model: mySuppliesInfo, deliveryDataApp: deliveryDataApp, arrivalDataApp: arrivalDataApp).subscribe(onNext: { model in
            if let suc = success {
                suc(model)
            }
        }, onError: { (error) in
            if let fail = failure, let err = error as? APIError {
                fail(err)
            }
        }).disposed(by: disposeBag)
    }
    
    func search(mobile:String, success: ((SearchCarrierModel)->())?,
                  failure: ((APIError)->())?) {
        searchModel.searchCarrier(mobile: mobile).subscribe(onNext: { model in
            if let suc = success {
                suc(model)
            }
        }, onError: { (error) in
            if let fail = failure, let err = error as? APIError {
                fail(err)
            }
        }).disposed(by: disposeBag)
    }
    
    func query(success: ((QueryPriceModel)->())?,
                  failure: ((APIError)->())?) {
        queryPriceModel.query(model: mySuppliesInfo).subscribe(onNext: { model in
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
