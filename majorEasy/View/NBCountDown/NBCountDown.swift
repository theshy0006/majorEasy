//
//  NBCountDown.swift
//  NoteBook
//
//  Created by dede wang on 2019/10/20.
//  Copyright © 2019 com.boc. All rights reserved.
//

import UIKit

/* 用法演示：
 //倒计时
 let countDown = NBCountDown(codeBtn: msgCodeButton)//实例化
 countDown.isCounting = true//开启倒计时
 */


import UIKit

@objc class NBCountDown : NSObject {
    
    @objc init(codeBtn: UIButton) {
        self.codeButton = codeBtn
        
    }
    
    private var countdownTimer: Timer?
    var codeButton: UIButton
    private var remainingSeconds: Int = 0 {
        willSet {
            codeButton.setTitle("\(newValue)s", for: .normal)
            
            if newValue <= 0 {
                codeButton.setTitle("重新获取", for: .normal)
                isCounting = false
            }
        }
    }
    @objc var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
                
                remainingSeconds = 60
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
            }
            
            codeButton.isUserInteractionEnabled = !newValue
        }
    }
    @objc private func updateTime() {
        remainingSeconds -= 1
    }
}
