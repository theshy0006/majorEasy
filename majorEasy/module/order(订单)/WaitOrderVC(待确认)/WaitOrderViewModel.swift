//
//  WaitOrderViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/30.
//

import UIKit

class WaitOrderViewModel: NBViewModel {
    var orderModel = OrderModel()
    var cancleModel = CancleOrderModel()
    var finishModel = FinishOrderModel()

    var pageNum = 1
    var loadMore = false
    var dataSource:[OrderItem] = []
    //获取短信验证码（）
    func getAllOrderList(
                  success: (()->())?,
                  failure: ((APIError)->())?) {
        orderModel.getMyAppOrders(pageNum: pageNum, pageSize: 10, state: 1).subscribe(onNext: { [weak self] model in
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
    
    
    func cancle(orderNum : String,
                          success: (()->())?,
                          failure: ((APIError)->())?) {
        cancleModel.cancleOrder(orderNum: orderNum).subscribe(onNext: { [weak self] _ in
            if let suc = success {
                for idx in 0..<(self?.dataSource.count)! {
                    if( self?.dataSource[idx].orderNum == orderNum ) {
                        self?.dataSource.remove(at: idx)
                        break
                    }
                }
                suc()
            }
        }, onError: { (error) in
            if let fail = failure, let err = error as? APIError {
                fail(err)
            }
        }).disposed(by: disposeBag)
        
    }
    
    func finish(orderNum : String,
                          success: (()->())?,
                          failure: ((APIError)->())?) {
        finishModel.finishOrder(orderNum: orderNum).subscribe(onNext: { [weak self] _ in
            if let suc = success {
                for idx in 0..<(self?.dataSource.count)! {
                    if( self?.dataSource[idx].orderNum == orderNum ) {
                        self?.dataSource.remove(at: idx)
                        break
                    }
                }
                suc()
            }
        }, onError: { (error) in
            if let fail = failure, let err = error as? APIError {
                fail(err)
            }
        }).disposed(by: disposeBag)
        
    }
}
