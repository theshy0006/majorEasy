//
//  ApplyViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/11/19.
//

import UIKit

class ApplyViewModel: NBViewModel {
    var driverModel = DriverModel()
    var pageNum = 1
    var loadMore = false
    var dataSource:[DriverItem] = []
    //获取短信验证码（）
    func getSuppliesByParam(
                  success: (()->())?,
                  failure: ((APIError)->())?) {
        driverModel.getDriverJobWantedList(pageNum: pageNum, pageSize: 10, workAreaCode: "", job: "").subscribe(onNext: { [weak self] model in
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
