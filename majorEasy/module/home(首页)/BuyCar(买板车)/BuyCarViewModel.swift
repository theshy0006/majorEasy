//
//  BuyCarViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/11/18.
//

import Foundation
import HandyJSON
import RxSwift

class BuyCarViewModel: NBViewModel {
    //轮播图
    var imageModel = FlatbedHomePagePics()
    var companyModel = FlatbedCompanysModel()
    var images:[String] = []
    var dataSource:[FlatbedCompanysItem] = []
    
    func getHomeImages(
                  success: ((FlatbedHomePagePics)->())?,
                  failure: ((APIError)->())?) {
        imageModel.getFlatbedHomePagePics().subscribe(onNext: { model in
            if let suc = success {
                suc(model)
            }
        }, onError: { (error) in
            if let fail = failure, let err = error as? APIError {
                fail(err)
            }
        }).disposed(by: disposeBag)
    }
    
    func getCompanys(
                  success: ((FlatbedCompanysModel)->())?,
                  failure: ((APIError)->())?) {
        companyModel.getFlatbedCompanys().subscribe(onNext: { model in
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
