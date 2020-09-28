//
//  MyVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/24.
//

import UIKit

class MyVC: BaseVC {
    

    override func setUpData() {
    }
    
    override func setUpView() {
        self.navigationItem.title = "my".localized
        createEmptyResultUI()
    }

}
