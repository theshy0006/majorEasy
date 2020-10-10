//
//  CarSourceVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/9.
//

import UIKit

class CarSourceVC: BaseVC {

    lazy var sortSelectView = NBSelectView().then {
        $0.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 40)
        $0.backgroundColor = UIColor.white
    }
    

    override func setUpView() {
        self.view.addSubview(self.sortSelectView)
        self.sortSelectView.setUp(sortSelectView.firstBtn, withText: "出发地")
        self.sortSelectView.setUp(sortSelectView.secondBtn, withText: "目的地")
        self.sortSelectView.setUp(sortSelectView.sortBtn, withText: "车长车型")
        
        self.sortSelectView.itemBtnBlock = { index in
            print(index)
        }
    }

}
