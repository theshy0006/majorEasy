//
//  GoodsOwenrViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/24.
//

import UIKit

class GoodsOwenrViewModel: NBViewModel {

    var uploadModel = UploadImageModel()
    var subUserModel = SubUserReviewModel()
    
    func uploadFrontImage(image: UIImage,
                  success: ((UploadImageModel)->())?,
                  failure: ((APIError)->())?) {
        uploadModel.uploadFrontImage(image: image).subscribe(onNext: { model in
            if let suc = success {
                suc(model)
            }
        }, onError: { (error) in
            if let fail = failure, let err = error as? APIError {
                fail(err)
            }
        }).disposed(by: disposeBag)
    }
    
    func uploadBackImage(image: UIImage,
                  success: ((UploadImageModel)->())?,
                  failure: ((APIError)->())?) {
        uploadModel.uploadBackImage(image: image).subscribe(onNext: { model in
            if let suc = success {
                suc(model)
            }
        }, onError: { (error) in
            if let fail = failure, let err = error as? APIError {
                fail(err)
            }
        }).disposed(by: disposeBag)
    }
    
    func subUser(userRealName: String,
                 idCardNumber: String,
                 idCardFrontImgKey: String,
                 idCardReverseImgKey: String,
                  success: ((SubUserReviewModel)->())?,
                  failure: ((APIError)->())?) {
        subUserModel.subUserReview(userRealName: userRealName, idCardNumber: idCardNumber, idCardFrontImgKey: idCardFrontImgKey, idCardReverseImgKey: idCardReverseImgKey).subscribe(onNext: { model in
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


