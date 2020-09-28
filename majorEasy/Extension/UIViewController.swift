//
//  UIViewController.swift
//  majorEasy
//
//  Created by dede wang on 2018/12/29.
//  Copyright © 2018 dede wang. All rights reserved.
//

//重写初始化方法
//override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//}


import UIKit

extension UIViewController {
    
    // 设置导航栏左侧图片按钮
    func setNavBarLeftBtn(normalImage:String, selector:Selector) {
        let leftBarItem = UIBarButtonItem(image: UIImage(named:normalImage)?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(popBack))
        self.navigationItem.leftBarButtonItem = leftBarItem
    }
    
    //设置导航栏右侧图片按钮
    func setNavBarRightBtn(normalImage:String, selector:Selector) {
        let rightBarBtn = UIBarButtonItem(title: "", style: .plain, target: self,
                                          action: #selector(gotoForward))
        rightBarBtn.image = UIImage(named:normalImage)?.withRenderingMode(.alwaysOriginal)
        
        //用于消除右边空隙，要不然按钮顶不到最前面
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                     action: nil)
        spacer.width = 10
        self.navigationItem.rightBarButtonItems = [rightBarBtn, spacer]
    }

    //默认返回按钮
    @objc func popBack() {
        if let nums = self.navigationController?.viewControllers.count {
            if (nums > 1) {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    //默认返回按钮
    @objc func popBackHome() {
        self.navigationController?.popToRootViewController(animated: false)
    }
    //向前返回几个页面
    @objc func popVC(_ num: Int) {
        if let vcCount = self.navigationController?.viewControllers.count {
            if (vcCount >= num+1) {
                guard let viewControllers = self.navigationController?.viewControllers else {return}
                let preVC: UIViewController = viewControllers[vcCount-num-1]
                self.navigationController?.popToViewController(preVC, animated: true)
            }
        }
    }
    
    func initNavigation() {
        //设置导航栏字体
        let dict:NSDictionary = [NSAttributedString.Key.foregroundColor: color_title,NSAttributedString.Key.font : PingFangMedium(18)]
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : AnyObject]
        //给二级页面添加leftItem返回按钮
        if let nums = self.navigationController?.viewControllers.count {
            if (nums > 1)
            {
                self.setNavBarLeftBtn(normalImage: "backUpImage", selector: #selector(popBack))
            }
        }
    }
    
    //点击导航栏右侧按钮事件
    @objc func gotoForward(){
    }
    
    /// 添加current方法，使用该方法可以直接找到当消息推送到来时，当前用户停留在哪个页面。
    class func current(base: UIViewController? = kWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return current(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return current(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return current(base: presented)
        }
        return base
    }
 
}
