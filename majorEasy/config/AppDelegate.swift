//
//  AppDelegate.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    public var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        //初始化第三方库
        self.launchPartner(application:application, launchOptions: launchOptions)
        //加载用户缓存数据
        DataCenterManager.default.load()
        
        if (DataCenterManager.default.isLogin) {
            self.setUpTabBar()
        } else {
            self.setUpLoginVC()
        }
        
        
        window?.makeKeyAndVisible()
        LanchManager.launchAnimation()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if( url.host == "oauth") {
            //微信登录
        } else if( url.host == "pay" ) {
            //微信支付
        } else if( url.host == "platformId=wechat") {
            return WXApi.handleOpen(url, delegate: WXApiManager.shared())
        } else {
            return true
        }
        return true
        
    }
}

extension AppDelegate {
    //MARK: -- 显示Tabbar
    func setUpTabBar() {
        let tabbar = TabbarVC()
        tabbar.selectedIndex = 0
        self.window?.rootViewController = tabbar
        
    }
    
    //MARK: --显示LoginVC
    func setUpLoginVC() {
        self.window?.rootViewController = NavigationVC(rootViewController: LoginVC())
    }
}

