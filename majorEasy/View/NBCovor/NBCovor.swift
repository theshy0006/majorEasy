//
//  NBCovor.swift
//  NoteBook
//
//  Created by dede wang on 2019/10/20.
//  Copyright © 2019 com.boc. All rights reserved.
//

import UIKit

class NBCovor: UIView, CAAnimationDelegate {
    
    weak var fromView: UIView?              // 显示在此视图上
    weak var contentView: UIView?           // 显示的视图
    var style: NBCovorStyle = .translucent  // 半透明
    var animStyle: NBCoverAnimStyle = .bottom  // 从底部弹出
    var notclick: Bool = true                 //是否能点击
    let bgColor: UIColor = UIColor.black.withAlphaComponent(0.3)
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        self.autoresizingMask = .flexibleWidth
        self.autoresizingMask = .flexibleHeight
    }
    
    convenience init(_ fromView: UIView? = nil, contentView: UIView, style: NBCovorStyle = .translucent, animStyle: NBCoverAnimStyle = .bottom, notclick: Bool = true ) {
        self.init(frame: CGRect.zero)
        self.fromView = fromView
        self.contentView = contentView
        self.style = style
        self.animStyle = animStyle
        self.notclick = notclick
        
        if let fromV = self.fromView {
            fromV.addSubview(self)
        } else {
            guard let window = kWindow else { return }
            window.addSubview(self)
            self.fromView = window
        }
        
        switch style {
        case .translucent:
            setupTranslucentCover() // 半透明
        case .transparent:
            setupTransparentCover() // 全透明
        case .blur:
            setupBlurCover() // 高斯模糊
        }
        
        showCover()
    }
    
    /// 半透明
    func setupTranslucentCover() {
        self.backgroundColor = bgColor
        self.coverAddTap()
    }
    /// 全透明
    func setupTransparentCover() {
        self.backgroundColor = UIColor.clear
        self.coverAddTap()
    }
    /// 高斯模糊
    func setupBlurCover() {
        self.backgroundColor = UIColor.clear
        self.coverAddTap()
        
        let blur: UIBlurEffect = UIBlurEffect.init(style: .light)
        let effectview: UIVisualEffectView = UIVisualEffectView.init(effect: blur)
        effectview.frame = self.bounds
        
        self.addSubview(effectview)
    }
    
    func coverAddTap() {
        if notclick {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hide))
            self.addGestureRecognizer(tap)
        }
    }
    
    func showCover() {
        guard let contentView = self.contentView else {return}
        guard let fromView = self.fromView else {return}
        fromView.addSubview(contentView)
        contentView.centerX = fromView.centerX
        switch animStyle {
        case .bottom:
            contentView.top = fromView.height
            UIView.animate(withDuration: kAnimDuration, animations: { [weak self] in
                guard let weakSelf = self else {return}
                guard let contentView = weakSelf.contentView else {return}
                guard let fromView = weakSelf.fromView else {return}
                fromView.bringSubviewToFront(contentView)
                contentView.top = fromView.height - contentView.height
                }, completion: { _ in
            })
            break
        case .center:
            contentView.top = fromView.height
            UIView.animate(withDuration: kAnimDuration, animations: { [weak self] in
                guard let weakSelf = self else {return}
                guard let contentView = weakSelf.contentView else {return}
                guard let fromView = weakSelf.fromView else {return}
                fromView.bringSubviewToFront(contentView)
                contentView.centerY = fromView.centerY
                }, completion: { _ in
            })
            break
        default:
            break
        }
    }
    
    func hideCover(_ completion: @escaping () -> Void) -> Void {
        switch animStyle {
        case .bottom:
            UIView.animate(withDuration: kAnimDuration, animations: { [weak self] in
                guard let weakSelf = self else {return}
                guard let contentView = weakSelf.contentView else {return}
                guard let fromView = weakSelf.fromView else {return}
                contentView.top = fromView.height
            }, completion: { [weak self] make in
                guard let weakSelf = self else {return}
                weakSelf.remove()
                //TODO: 待修复
                completion()
            })
            break
        case .center:
            UIView.animate(withDuration: kAnimDuration, animations: { [weak self] in
                guard let weakSelf = self else {return}
                guard let contentView = weakSelf.contentView else {return}
                guard let fromView = weakSelf.fromView else {return}
                contentView.top = fromView.height
                }, completion: { [weak self] make in
                    guard let weakSelf = self else {return}
                    weakSelf.remove()
                    //TODO: 待修复
                    completion()
            })
            break
        default:
            remove()
        }
    }
    
    @objc func hide() {
        hideCover({})
    }
    
    func remove() {
        self.removeFromSuperview()
        contentView?.removeFromSuperview()
    }
    
    func remove(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.remove()
        }, completion: { _ in
            completion()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

