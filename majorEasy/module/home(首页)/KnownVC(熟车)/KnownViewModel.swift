//
//  KnownViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/12.
//

import UIKit

class KnownViewModel: NBViewModel {
    var carModel = CarModel()
    var pageNum = 1
    var loadMore = false
    var dataSource:[CarInfo] = []
    //获取短信验证码（）
    func getMyFamiliarVehicles(
                  success: (()->())?,
                  failure: ((APIError)->())?) {
        carModel.getMyFamiliarVehicles(pageNum: pageNum, pageSize: 10, departurePlaceCode: "").subscribe(onNext: { [weak self] model in
            if let suc = success {
                guard let weakSelf = self else {return}
                if (!weakSelf.loadMore) {
                    weakSelf.dataSource.removeAll()
                }
                
                if( model.value.list.count < 10 ) {
                    weakSelf.pageNum = -1
                } else {
                    weakSelf.pageNum = weakSelf.pageNum + 1
                }
                weakSelf.dataSource = weakSelf.dataSource + model.value.list
                suc()
            }
        }, onError: { (error) in
            if let fail = failure, let err = error as? APIError {
                fail(err)
            }
        }).disposed(by: disposeBag)
    }
}
