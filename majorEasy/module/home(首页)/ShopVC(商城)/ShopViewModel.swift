//
//  ShopViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/11/19.
//

import UIKit

class ShopViewModel: NBViewModel {
    var goodModel = GoodsModel()
    var pageNum = 1
    var loadMore = false
    var dataSource:[GoodsItem] = []
    //获取短信验证码（）
    func getSuppliesByParam(
                  success: (()->())?,
                  failure: ((APIError)->())?) {
        goodModel.getGoods(pageNum: pageNum, pageSize: 10).subscribe(onNext: { [weak self] model in
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
