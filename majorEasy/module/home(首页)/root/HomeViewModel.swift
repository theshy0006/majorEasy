//
//  HomeViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/28.
//

import Foundation
import HandyJSON
import RxSwift

class HomeViewModel: NBViewModel {
    //轮播图
    var imageModel = HomeImagesModel()
    var shareModel = ShareModel()
    var addAddress = AddAddress()
    var checkVersionModel = VersionCheckModel()
    
    var images:[String] = []
    
    func addressBook(address:[Dictionary<String, String>],
                     success: ((AddAddress)->())?,
                     failure: ((APIError)->())?) {
        addAddress.addAddress(addressBook: address).subscribe(onNext: { model in
               if let suc = success {
                   suc(model)
               }
           }, onError: { (error) in
               if let fail = failure, let err = error as? APIError {
                   fail(err)
               }
           }).disposed(by: disposeBag)
       }
    
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
    
    func getShareUrl(
                  success: (()->())?,
                  failure: ((APIError)->())?) {
        shareModel.getShareUrl().subscribe(onNext: { model in
            if let suc = success {
                DataCenterManager.default.shareUrl = model.value ?? ""
                suc()
                
            }
        }, onError: { (error) in
            if let fail = failure, let err = error as? APIError {
                fail(err)
            }
        }).disposed(by: disposeBag)
    }
    
    func checkVersion(
                  success: ((VersionCheckModel)->())?,
                  failure: ((APIError)->())?) {
        checkVersionModel.checkVersion(versionCode: LocalVersionCode, versionName: "0.0.1").subscribe(onNext: { model in
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
