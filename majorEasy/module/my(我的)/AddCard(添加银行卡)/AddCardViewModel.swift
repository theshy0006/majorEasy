//
//  AddCardViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/11/10.
//

import UIKit

class AddCardViewModel: NBViewModel {
    let bankModel = BankModel()
    let bindBank = BindBankModel()
    
    var dataSource:[BankItem] = []
    var showItemArray:[NBActionSheetItem] = []
    
    
    
    func getBanks(success: (()->())?,
                  failure: ((APIError)->())?) {
        bankModel.getBank().subscribe(onNext: { [weak self] model in
            if let suc = success {
                guard let weakSelf = self else {return}
                    weakSelf.dataSource.removeAll()
                weakSelf.dataSource = weakSelf.dataSource + model.value
                weakSelf.initShowItems()
                suc()
            }
        }, onError: { (error) in
            if let fail = failure, let err = error as? APIError {
                fail(err)
            }
        }).disposed(by: disposeBag)
    }
    
    func initShowItems() {
        showItemArray.removeAll()
        for item in dataSource {
            let item1 = NBActionSheetItem()
            item1.title = item.bankName ?? ""
            showItemArray.append(item1)
        }

    }
    
    func bind( cardType: Int,
               bankId: Int,
               cardNumber: String,
               cardHolderName: String,
               phoneNumber: String,
        success: ((BindBankModel)->())?,
                      failure: ((APIError)->())?) {
        bindBank.bindBank(cardType: cardType,
                          bankId: bankId,
                          cardNumber: cardNumber,
                          cardHolderName: cardHolderName,
                          phoneNumber: phoneNumber).subscribe(onNext: { model in
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
