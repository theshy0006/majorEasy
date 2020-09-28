//
//  NavigationVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/24.
//

import UIKit

class NavigationVC: UINavigationController, UINavigationControllerDelegate {
    
    var popDelegate: UIGestureRecognizerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage.imageWithColor(color: color_navigation), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage.imageWithColor(color: shadowImageColor)
        
        //设置导航栏为不透明
        self.navigationBar.isTranslucent = false
        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        self.delegate = self
    }
    
    //设置状态栏颜色
    //如果一个viewController 是在导航里面，他不可以通过下面这个方法改变状态栏的颜色，是有导航对象来管理状态栏的颜色的。
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        //实现滑动返回功能
        //清空滑动返回手势的代理就能实现
        if viewController == self.viewControllers[0] {
            self.interactivePopGestureRecognizer!.delegate = self.popDelegate
        } else {
            self.interactivePopGestureRecognizer!.delegate = nil
        }
    }
}

