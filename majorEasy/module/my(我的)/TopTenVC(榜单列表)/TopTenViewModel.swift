//
//  TopTenViewModel.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/25.
//

import UIKit

class TopTenViewModel: NBViewModel {
    
    // 奖励对象
    var integralModel = IntegralModel()
    // 充值对象
    var rechargeModel = RechargeModel()
    // 邀请对象
    var inviteModel = InviteModel()
    
    var pageNum = 1
    var rank = 1
    var loadMore = false
    var dataSource:[TopTenItem] = []

    func getIntegralList(
                  success: (()->())?,
                  failure: ((APIError)->())?) {
        integralModel.getIntegral(pageNum: pageNum, pageSize: 10, rank: self.rank).subscribe(onNext: { [weak self] model in
            if let suc = success {
                guard let weakSelf = self else {return}
                if (!weakSelf.loadMore) {
                    weakSelf.dataSource.removeAll()
                }
                
                if( model.value.count < 10 ) {
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
    
    func getRechargeList(
                  success: (()->())?,
                  failure: ((APIError)->())?) {
        rechargeModel.getRecharge(pageNum: pageNum, pageSize: 10, rank: self.rank).subscribe(onNext: { [weak self] model in
            if let suc = success {
                guard let weakSelf = self else {return}
                if (!weakSelf.loadMore) {
                    weakSelf.dataSource.removeAll()
                }
                
                if( model.value.count < 10 ) {
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
    
    func getInviteList(
                  success: (()->())?,
                  failure: ((APIError)->())?) {
        inviteModel.getInvite(pageNum: pageNum, pageSize: 10, rank: self.rank).subscribe(onNext: { [weak self] model in
            if let suc = success {
                guard let weakSelf = self else {return}
                if (!weakSelf.loadMore) {
                    weakSelf.dataSource.removeAll()
                }
                
                if( model.value.count < 10 ) {
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
