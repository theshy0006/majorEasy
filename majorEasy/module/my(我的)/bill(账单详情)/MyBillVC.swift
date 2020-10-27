//
//  MyBillVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/27.
//

import UIKit

class MyBillVC: BaseVC {

    let viewModel = OrderViewModel()
    
    lazy var pageTabView = XXPageTabView(childControllers: self.children, childTitles: ["账单","充值","提现"]).then {
        $0.delegate = self
        $0.titleStyle = .gradient
        $0.indicatorStyle = .followText
        $0.selectedTabIndex = 0
        $0.maxNumberOfPageItems = 6
        $0.separatorColor = RGBHex(0xf4f4f4)
        $0.unSelectedColor = RGBHex(0x666666)
        $0.selectedColor = RGBHex(0x7792BB)
    }
    
    override func setUpData() {
    }
    
    override func setUpView() {
        self.navigationItem.title = "账单详情"
        self.addChildVC()
        self.view.addSubview(self.pageTabView)
        self.pageTabView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
    }
    
    func addChildVC() {
        self.addChild(BillListVC())
        self.addChild(RechargeVC())
        self.addChild(WithDrawVC())
    }

}

extension MyBillVC: XXPageTabViewDelegate {
    func pageTabViewDidEndChange() {
        
    }
}
