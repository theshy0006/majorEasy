//
//  OrderVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/24.
//

import UIKit

class OrderVC: BaseVC {

    let viewModel = OrderViewModel()

    lazy var pageTabView = XXPageTabView(childControllers: self.children, childTitles: ["全部","待确认","运输中","已完成","待评价","已取消"]).then {
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
        self.navigationItem.title = "myOrder".localized
        self.addChildVC()
        self.view.addSubview(self.pageTabView)
        self.pageTabView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
    }
    
    func addChildVC() {

        let allVC = AllOrderVC()
        self.addChild(allVC)
        
        let waitVC = WaitOrderVC()
        self.addChild(waitVC)
        
        let transferVC = TransferOrderVC()
        self.addChild(transferVC)
        
        let finishVC = FinishOrderVC()
        self.addChild(finishVC)
        
        let gradeVC = GradeOrderVC()
        self.addChild(gradeVC)
        
        let cancelVC = CancelOrderVC()
        self.addChild(cancelVC)
    }

}

extension OrderVC: XXPageTabViewDelegate {
    func pageTabViewDidEndChange() {
        
    }
}

