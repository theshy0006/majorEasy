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
                        imgName: "tab-home", selImgName: "tab-home-current")
        self.addClildVC(PostVC(), title: "post".localized,
                        imgName: "tab-chat", selImgName: "tab-chat-current")
        self.addClildVC(OrderVC(), title: "shortMovie".localized,
                        imgName: "tab-movie", selImgName: "tab-movie-current")
        self.addClildVC(MyVC(), title: "my".localized,
                        imgName: "tab-mine", selImgName: "tab-mine-current")
    }
    
    func addClildVC(_ clildVC: UIViewController, title: String, imgName: String, selImgName: String) {
        clildVC.tabBarItem.title = title
        clildVC.tabBarItem.image = UIImage(named: imgName)
        clildVC.tabBarItem.selectedImage = UIImage(named: selImgName)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        clildVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor  : tabbarFontSelectColor], for: .selected)
        self.addChild(NavigationVC(rootViewController: clildVC))
    }

}
