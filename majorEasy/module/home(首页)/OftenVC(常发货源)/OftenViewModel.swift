//
//  OftenViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/9.
//

import UIKit

class OftenViewModel: NBViewModel {
    var orderModel = MySuppliesModel()

    var pageNum = 1
    var loadMore = false
    var dataSource:[MySuppliesInfo] = []
    //获取短信验证码（）
    func getMySuppliesModel(
                  success: (()->())?,
                  failure: ((APIError)->())?) {
        orderModel.getMySuppliesModel(pageNum: pageNum, pageSize: 10, sortType: "3", appSupplyStatus: "").subscribe(onNext: { [weak self] model in
            if let suc = success {
                guard let weakSelf = self else {return}
                if (!weakSelf.loadMore) {
                    weakSelf.dataSource.removeAll()
                }
                
                if( model.value.count < 10 ) {
                    weakSelf.pageNum = -1
                } else {
                    weakSelf.pageNum = weakSelf.pageNum + 1
                }
                weakSelf.dataSource = weakSelf.dataSource + model.value
                suc()
            }
        }, onError: { (error) in
            if let fail = failure, let err = error as? APIError {
                fail(err)
            }
        }).disposed(by: disposeBag)
    }
}
