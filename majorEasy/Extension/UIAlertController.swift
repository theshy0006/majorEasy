//
//  UIAlertController.swift
//  majorEasy
//
//  Created by dede wang on 2018/12/6.
//  Copyright © 2018 dede wang. All rights reserved.
//

import UIKit

//扩展UIAlertController
extension UIAlertController {
    //在指定视图控制器上弹出普通消息提示框
    static func showAlert(message: String, in viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel))
        viewController.present(alert, animated: true)
    }
    
    //在根视图控制器上弹出普通消息提示框
    static func showAlert(message: String) {
        if let vc = kWindow?.rootViewController {
            showAlert(message: message, in: vc)
        }
    }

}
