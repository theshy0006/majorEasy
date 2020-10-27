//
//  WithDrawViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/28.
//

import UIKit

class WithDrawViewModel: NBViewModel {
    var withDrawModel = WithDrawModel()
    var pageNum = 1
    var loadMore = false
    var dataSource:[WithDrawItem] = []
    //获取短信验证码（）
    func getWithDraw(
                  success: (()->())?,
                  failure: ((APIError)->())?) {
        withDrawModel.getWithDraw(pageNum: pageNum, pageSize: 10).subscribe(onNext: { [weak self] model in
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
