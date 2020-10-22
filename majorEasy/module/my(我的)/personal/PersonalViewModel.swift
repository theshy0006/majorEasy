//
//  PersonalViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/22.
//

import UIKit

class PersonalViewModel: NBViewModel {

    var uploadModel = UploadImageModel()
    var saveModel = SaveUserInfo()

    func uploadHeadImage(image: UIImage,
                  success: ((UploadImageModel)->())?,
                  failure: ((APIError)->())?) {
        uploadModel.uploadImage(image: image).subscribe(onNext: { model in
            if let suc = success {
                suc(model)
            }
        }, onError: { (error) in
            if let fail = failure, let err = error as? APIError {
                fail(err)
            }
        }).disposed(by: disposeBag)
    }
    
    func save(headImage: String,
              userName: String,
              email: String,
                  success: ((SaveUserInfo)->())?,
                  failure: ((APIError)->())?) {
        saveModel.save(headPortraitKey: headImage, userName: userName, emailAddress: email).subscribe(onNext: { model in
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
