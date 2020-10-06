//
//  SpecialLineViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/6.
//

import UIKit

class SpecialLineViewModel: NBViewModel {
    var lineModel = DedicatedLinesModel()
    var loadPlaceCode = ""
    var unloadPlaceCode = ""
    var pageNum = 1
    var loadMore = false
    var dataSource:[DedicatedLinesItem] = []
    //获取短信验证码（）
    func getDedicatedLines(
                           location:String,
                  success: (()->())?,
                  failure: ((APIError)->())?) {
        lineModel.getDedicatedLines(
                                    loadPlaceCode:loadPlaceCode,
                                    unloadPlaceCode:unloadPlaceCode,
                                    pageNum: pageNum,
                                    pageSize: 10,
                                    location: location).subscribe(onNext: { [weak self] model in
            if let suc = success {
                guard let weakSelf = self else {return}
                if (!weakSelf.loadMore) {
                    weakSelf.dataSource.removeAll()
                }
                
                if(model.value.count < 10) {
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
