//
//  MyVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/29.
//

import UIKit

class MyVC: BaseVC {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var moneyView: UIView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var toolView: UIView!
    @IBOutlet weak var headerView: UIView!
    
    override func setUpData() {
        
    }
    
    override func setUpView() {
        headerView.layer.cornerRadius = 30
        self.view.backgroundColor = RGBHex(0xF6F6F6)
        self.hideNavigationBar = true
        self.moneyView.addShadow(RGBHex(0xe2e2e2))
        self.messageView.addShadow(RGBHex(0xe2e2e2))
        self.toolView.addShadow(RGBHex(0xe2e2e2))
        topView.snp.updateConstraints { (make) -> Void in
            make.height.equalTo(162+StatusHeight)
        }
    }

}
