//
//  OrderVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/24.
//

import UIKit

class OrderVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func setUpData() {
    }
    
    override func setUpView() {
        self.navigationItem.title = "music".localized
        createEmptyResultUI()
    }

}
