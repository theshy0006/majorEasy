//
//  MyCardViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/11/10.
//

import UIKit

class MyCardViewModel: NBViewModel {
    
    let model = CardModel()
    let deleteModel = DeleteCardModel()
    var pageNum = 1
    var loadMore = false
    var dataSource:[CardItem] = []
    //获取短信验证码（）
    func getMyCard(
                  success: (()->())?,
                  failure: ((APIError)->())?) {
        model.getMyCard().subscribe(onNext: { [weak self] model in
            if let suc = success {
                guard let weakSelf = self else {return}
                    weakSelf.dataSource.removeAll()
                weakSelf.dataSource = weakSelf.dataSource + model.value
                suc()
            }
        }, onError: { (error) in
            if let fail = failure, let err = error as? APIError {
                fail(err)
            }
        }).disposed(by: disposeBag)
    }
    
    func delete(item: CardItem, success: (()->())?,
                failure: ((APIError)->())?) {
        deleteModel.deleteCard(cardNo: "\(item.id)").subscribe(onNext: {  model in
          if let suc = success {
              suc()
          }
      }, onError: { (error) in
          if let fail = failure, let err = error as? APIError {
              fail(err)
          }
      }).disposed(by: disposeBag)
  }
}
