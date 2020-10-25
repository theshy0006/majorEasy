//
//  TopTenTV.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/25.
//

import UIKit

class TopTenTV: BaseVC {

    let viewModel = OrderViewModel()

    var type = 0
    
    convenience init(type: Int) {
        self.init()
        self.type = type
    }
    
    lazy var pageTabView = XXPageTabView(childControllers: self.children, childTitles: ["一级","二级","三级"]).then {
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
        if(type == 0) {
            self.navigationItem.title = "邀请榜单"
        } else if(type == 1) {
            self.navigationItem.title = "奖励榜单"
        } else {
            self.navigationItem.title = "充值奖励"
        }
        
        
        
        self.addChildVC()
        self.view.addSubview(self.pageTabView)
        self.pageTabView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
    }
    
    func addChildVC() {

        let allVC = SubTopTenVC.init(type: type, rank: 1)
        self.addChild(allVC)
        
        let waitVC = SubTopTenVC.init(type: type, rank: 2)
        self.addChild(waitVC)
        
        let transferVC = SubTopTenVC.init(type: type, rank: 3)
        self.addChild(transferVC)
    }

}

extension TopTenTV: XXPageTabViewDelegate {
    func pageTabViewDidEndChange() {
        
    }
}

