//
//  RechargeViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/28.
//

import UIKit

class RechargeViewModel: NBViewModel {
    var rechargeModel = RechargeListModel()
    var pageNum = 1
    var loadMore = false
    var dataSource:[RechargeListItem] = []
    //获取短信验证码（）
    func getRecharge(
                  success: (()->())?,
                  failure: ((APIError)->())?) {
        rechargeModel.getRecharge(pageNum: pageNum, pageSize: 10).subscribe(onNext: { [weak self] model in
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
