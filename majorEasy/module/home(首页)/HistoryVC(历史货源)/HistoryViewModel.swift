//
//  HistoryViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/9.
//

import UIKit

class HistoryViewModel: NBViewModel {
    var orderModel = MySuppliesModel()
    var deleteModel = DeleteModel()
    var pageNum = 1
    var loadMore = false
    var dataSource:[MySuppliesInfo] = []
    //获取短信验证码（）
    func getMySuppliesModel(
                  success: (()->())?,
                  failure: ((APIError)->())?) {
        orderModel.getMySuppliesModel(pageNum: pageNum, pageSize: 10, sortType: "1", appSupplyStatus: "").subscribe(onNext: { [weak self] model in
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
    //删除货源
    func deleteMySupplies(supplyNum: String,
                          success: (()->())?,
                          failure: ((APIError)->())?) {
        deleteModel.deleteMySupplies(supplyNum: supplyNum).subscribe(onNext: {[weak self] model in
            if let suc = success {
                for idx in 0..<(self?.dataSource.count)! {
                    if( self?.dataSource[idx].supplyNum == supplyNum ) {
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
