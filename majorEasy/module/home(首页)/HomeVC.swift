//
//  HomeVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/24.
//

import UIKit

class HomeVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpData() {
        
    }
    
    override func setUpView() {
        self.navigationItem.title = "homeTitle".localized
        self.setNavBarLeftBtn(normalText: "我是车主", selector: #selector(popBack))
        self.setNavBarRightBtn(normalImage: "客服", selector: #selector(gotoForward))
    }
    
    //点击导航栏右侧按钮事件
    @objc override func gotoForward(){
        NBUtility.showTelephone(self)
    }

}
