//
//  SecondCarVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/11/18.
//

import UIKit

class SecondCarVC: BaseVC {

    let viewModel = OrderViewModel()

    lazy var pageTabView = XXPageTabView(childControllers: self.children, childTitles: ["全部","一车一挂","车头","板车"]).then {
        $0.delegate = self
        $0.titleStyle = .gradient
        $0.indicatorStyle = .followText
        $0.selectedTabIndex = 0
        $0.maxNumberOfPageItems = 4
        $0.separatorColor = RGBHex(0xf4f4f4)
        $0.unSelectedColor = RGBHex(0x666666)
        $0.selectedColor = RGBHex(0x7792BB)
    }
    
    override func setUpData() {
    }
    
    override func setUpView() {
        self.navigationItem.title = "二手车"
        self.setNavBarRightBtn(normalImage: "blackAdd", selector: #selector(gotoForward))
        self.addChildVC()
        self.view.addSubview(self.pageTabView)
        self.pageTabView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
    }
    
    func addChildVC() {
        self.addChild(SecondCarListVC(type: 0))
        self.addChild(SecondCarListVC(type: 1))
        self.addChild(SecondCarListVC(type: 2))
        self.addChild(SecondCarListVC(type: 3))
    }

}

extension SecondCarVC: XXPageTabViewDelegate {
    func pageTabViewDidEndChange() {
        
    }
}
