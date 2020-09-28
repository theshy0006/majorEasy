//
//  NBHUDManager.swift
//  NoteBook
//
//  Created by dede wang on 2019/10/20.
//  Copyright © 2019 com.boc. All rights reserved.
//

import UIKit

@objc class NBHUDManager : NSObject {

    typealias HudCompletionClosure = () -> Void
    
    private let delay: TimeInterval = 4.0
    
    static let `default` = NBHUDManager()
    
    private var hud: MBProgressHUD = {
        let h = MBProgressHUD()
        h.removeFromSuperViewOnHide = true
        h.label.font = PingFangRegular(14)
        h.bezelView.style = .solidColor
        h.bezelView.backgroundColor = RGBHex(0x666666)
        h.mode = .indeterminate
        h.contentColor = .white
        return h
    }()
    
    /// 开启定时器
    ///
    /// - Parameter closure: 定时任务
    private func startTimer(completion closure: HudCompletionClosure?) {
        var timeCount = delay
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer.schedule(deadline: .now(), repeating: .seconds(1))
        timer.setEventHandler(handler: {
            timeCount = timeCount - 1
            if timeCount <= 0 {
                timer.cancel()
                DispatchQueue.main.async {
                    NBHUDManager.default.hud.hide(animated: true)
                    closure?()
                }
            }
        })
        timer.resume()
    }
    
    /// 显示菊花
    @objc class func showLoading() {
        DispatchQueue.main.async {
            NBHUDManager.default.showLoading(on: nil)
        }
    }
    
    /// 显示菊花
    ///
    /// - Parameter view: 在某个view上显示
    class func showLoading(on view: UIView) {
        DispatchQueue.main.async {
            NBHUDManager.default.showLoading(on: view)
        }
    }
    
    /// 显示菊花
    private func showLoading(on view: UIView?) {
        hud.mode = .indeterminate
        hud.detailsLabel.text = nil
        hud.label.text = nil
        if let view = view {
            view.addSubview(hud)
        } else {
            guard let window = kWindow else { return }
            window.addSubview(hud)
        }
        hud.show(animated: true)
    }
    
    /// 显示toast
    private func toast(_ text: String, on view: UIView?, completion closure: HudCompletionClosure?) {
        hud.mode = .text
        hud.label.text = text
        if let view = view {
            view.addSubview(hud)
        } else {
            guard let window = kWindow else { return }
            window.addSubview(hud)
        }
        hud.show(animated: true)
        if let closure = closure {
            startTimer(completion: closure)
        } else {
            startTimer(completion: nil)
        }
    }
    
    /// 隐藏菊花
@objc class func hidLoading() {
        NBHUDManager.default.hidLoading()
    }
    
    /// 隐藏菊花并显示toast
    class func hidLoadingThenShowToast(_ text: String,  completion closure: HudCompletionClosure? = nil) {
        NBHUDManager.default.hidLoadingThenShowToast(text, completion: closure)
    }
    
    /// 显示toast
    ///
    /// - Parameters:
    ///   - text: toast
    ///   - view: 在view上显示
    ///   - closure: 结束的操作
    @objc class func toast(_ text: String, on view: UIView? = nil, completion closure: HudCompletionClosure? = nil) {
        NBHUDManager.default.toast(text, on: view, completion: closure)
    }
    
    @objc class func toast(_ text: String) {
        NBHUDManager.default.toast(text, on: nil, completion: nil)
    }
    
    // MARK: - private method
    
    /// 隐藏菊花
    private func hidLoading() {
        hud.hide(animated: true)
    }
    
    /// 隐藏菊花并显示toast
    private func hidLoadingThenShowToast(_ text: String,  completion closure: HudCompletionClosure?) {
        hud.hide(animated: true)
        toast(text, on: nil, completion: closure)
    }
}
