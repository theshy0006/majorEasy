//
//  LanuhManager.swift
//  yunyou
//
//  Created by wangyang on 2020/3/31.
//  Copyright © 2020 com.boc. All rights reserved.
//

import UIKit

class LanchManager: NSObject {
    class func launchAnimation() {
        //获取启动视图
        let vc = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateViewController(withIdentifier: "launch")
        guard let window = kWindow else { return }
        window.addSubview(vc.view)
        UIView.animate(withDuration: 1, delay: 1.5, options: .beginFromCurrentState,
                       animations: {
                        vc.view.alpha = 0.0
                        let transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1.0)
                        vc.view.layer.transform = transform
        }) { (finished) in
            vc.view.removeFromSuperview()
        }
    }
}
