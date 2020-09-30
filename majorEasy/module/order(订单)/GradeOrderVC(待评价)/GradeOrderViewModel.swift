//
//  GradeOrderViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/30.
//

import UIKit

class GradeOrderViewModel: NBViewModel {
    var orderModel = OrderModel()
    
    var pageNum = 1
    var loadMore = false
    var dataSource:[OrderItem] = []
    //获取短信验证码（）
    func getAllOrderList(
                  success: (()->())?,
                  failure: ((APIError)->())?) {
        orderModel.getMyAppOrders(pageNum: pageNum, pageSize: 10, state: 5).subscribe(onNext: { [weak self] model in
            if let suc = success {
                guard let weakSelf = self else {return}
                if (!weakSelf.loadMore) {
                    weakSelf.dataSource.removeAll()
                }
                
                if(model.value.count == 0) {
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
