//
//  HomeViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/28.
//

import Foundation
import HandyJSON
import RxSwift

class HomeViewModel: NSObject {
    //轮播图
    var imageModel = HomeImagesModel()
    var images:[String] = []
    let disposeBag = DisposeBag()
    
    //获取短信验证码（）
    func getHomeImages(
                  success: ((HomeImagesModel)->())?,
                  failure: ((APIError)->())?) {
        imageModel.getHomeImages().subscribe(onNext: { model in
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
