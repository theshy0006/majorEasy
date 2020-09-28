//
//  NBTextFiled.swift
//  Notebook
//
//  Created by dede wang on 2019/9/20.
//  Copyright © 2019 com.boc. All rights reserved.
//

import UIKit

class NBTextFiled: UITextField {

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(paste(_:)) {
            //禁止粘贴
            return true
        }
        if action == #selector(select(_:)) {
            // 禁止选择
            return false
        }
        if action == #selector(selectAll(_:)){
            // 禁止全选
            return false
        }
        
        return super.canPerformAction(action, withSender: sender)
    }

}
