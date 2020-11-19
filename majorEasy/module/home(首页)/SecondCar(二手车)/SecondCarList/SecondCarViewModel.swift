//
//  SecondCarViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/11/19.
//

import UIKit

class SecondCarViewModel: NBViewModel {
    var orderModel = UsedVehicles()

    var pageNum = 1
    var loadMore = false
    var dataSource:[UsedVehiclesItem] = []
    //获取短信验证码（）
    func getOrderList(
                  type: Int,
                  success: (()->())?,
                  failure: ((APIError)->())?) {
        orderModel.getUsedVehicles(pageNum: pageNum, pageSize: 10, type: type).subscribe(onNext: { [weak self] model in
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
