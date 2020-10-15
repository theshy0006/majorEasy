//
//  TodayViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/12.
//

import UIKit

class TodayViewModel: NBViewModel {
    var suppliesModel = AllSuppliesModel()
    var pageNum = 1
    var loadMore = false
    var dataSource:[MySuppliesInfo] = []
    //获取短信验证码（）
    func getSuppliesByParam(
                  success: (()->())?,
                  failure: ((APIError)->())?) {
        suppliesModel.getSuppliesByParam(pageNum: pageNum, pageSize: 10, sortType: 1).subscribe(onNext: { [weak self] model in
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
