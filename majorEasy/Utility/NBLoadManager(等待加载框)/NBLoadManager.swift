//
//  NBLoadManager.swift
//  NoteBook
//
//  Created by dede wang on 2019/10/20.
//  Copyright © 2019 com.boc. All rights reserved.
//

import UIKit

@objc class NBLoadManager :NSObject{
    
    private var hudView: LoadingHUD?
    
    private static var _sharedInstance: NBLoadManager?
    
    typealias LoadCompletionClosure = () -> Void
    
    private override init() {} // 私有化init方法
    
    class func shared() -> NBLoadManager {
        guard let instance = _sharedInstance else {
            _sharedInstance = NBLoadManager()
            return _sharedInstance!
        }
        return instance
    }
    
    @objc class func hidLoading() {
        if let hud = NBLoadManager.shared().hudView {
            DispatchQueue.main.async {
                hud.hide()
            }
        }
    }
    
    /// 显示菊花
    @objc class func showLoading() {
        DispatchQueue.main.async {
            NBLoadManager.showLoadingView()
        }
    }
    
    class func showLoadingView(_ view: UIView? = nil, style: LoadingHudStyle = .cancel
        ) {
        if let hud = NBLoadManager.shared().hudView {
            DispatchQueue.main.async {
                hud.hide()
            }
        }

        if let view = view {
            NBLoadManager.shared().hudView = LoadingHUD(frame: view.frame, style: style)
            if let hud = NBLoadManager.shared().hudView {
                view.addSubview(hud)
                if style == .cancel {
                    hud.cancelblock = {
                        DispatchQueue.main.async {
                            hud.hide()
                        }
                    }
                }
            }
        } else {
            guard let window = kWindow else { return }
            NBLoadManager.shared().hudView = LoadingHUD(frame: window.frame, style: style)
            if let hud = NBLoadManager.shared().hudView {
                window.addSubview(hud)
                if style == .cancel {
                    hud.cancelblock = {
                        DispatchQueue.main.async {
                            hud.hide()
                        }
                    }
                }
            }
        }
    }

    //销毁单例对象
    class func destroy() {
        _sharedInstance = nil
    }
}
