//
//  LineDetailViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/7.
//

import UIKit

class LineDetailViewModel: NBViewModel {
    //轮播图
    var detailModel = DedicatedLineDetailModel()
    var images:[String] = []
    //获取短信验证码（）
    func getDetail(lineId: String,
                  success: ((DedicatedLineDetailModel)->())?,
                  failure: ((APIError)->())?) {
        detailModel.getDedicatedLineDetail(lineId: lineId).subscribe(onNext: { model in
            if let suc = success {
                suc(model)
                
            }
        }, onError: { (error) in
            if let fail = failure, let err = error as? APIError {
                fail(err)
            }
        }).disposed(by: disposeBag)
    }

}
