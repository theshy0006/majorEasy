//
//  TabbarVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/24.
//

import UIKit

class TabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.tintColor = tabbarFontSelectColor
        
        self.addClildVC(HomeVC(), title: "home".localized,
                        imgName: "首页-n", selImgName: "首页-p")
        self.addClildVC(PostVC(), title: "post".localized,
                        imgName: "发货-n", selImgName: "发货-p")
        self.addClildVC(OrderVC(), title: "order".localized,
                        imgName: "订单-n", selImgName: "订单-p")
        self.addClildVC(MyVC(), title: "my".localized,
                        imgName: "我的-n", selImgName: "我的-p")
    }
    
    func addClildVC(_ clildVC: UIViewController, title: String, imgName: String, selImgName: String) {
        clildVC.tabBarItem.title = title
        clildVC.tabBarItem.image = UIImage(named: imgName)
        clildVC.tabBarItem.selectedImage = UIImage(named: selImgName)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        clildVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor  : tabbarFontSelectColor], for: .selected)
        self.addChild(NavigationVC(rootViewController: clildVC))
    }

}
