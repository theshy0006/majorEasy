//
//  constant.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/24.
//

import UIKit

// 屏幕宽度
public let kScreenW = UIScreen.main.bounds.size.width
// 屏幕高度
public let kScreenH = UIScreen.main.bounds.size.height
//获取全局delegata
let kAppdelegate = UIApplication.shared.delegate as! AppDelegate
//获取全局窗口
let kWindow = kAppdelegate.window
//是否是苹果手机
public let IsIphone = (UIDevice.current.userInterfaceIdiom == .phone)
//是否是iphoneX以上机型
public let IsIphoneX = ScreenWidth >= 375.0 && ScreenHeight >= 812.0 && IsIphone
//屏幕的宽
public let ScreenWidth:CGFloat  = UIScreen.main.bounds.size.width
//屏幕的高
public let ScreenHeight:CGFloat = UIScreen.main.bounds.size.height
//状态栏的高
public let StatusHeight:CGFloat = IsIphoneX ? 44.0 : 20.0
//安全区顶部高度(没有导航栏)
//安全区的底部距离
public let SafeAreaBottomHeight:CGFloat = IsIphoneX ? 34 : 0
//安全区顶部的高度
public let SafeAreaTopHeight:CGFloat = IsIphoneX ? 88 : 64
//状态栏和导航栏总高度
public let NavBarAndStatusBarHeight:CGFloat = IsIphoneX ? 88.0 : 64.0
//TabBar高度
public let TabBarHeight:CGFloat = IsIphoneX ? (49.0 + 34.0) : (49.0)
/*导航条和Tabbar总高度*/
public let NavAndTabHeight = NavBarAndStatusBarHeight + TabBarHeight

// MARK:-- 颜色使用的封装
func RGB(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor {
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}

func RGBHex(_ rgbValue: Int) ->UIColor {
    let r = (rgbValue >> 16) & 0xFF
    let g = (rgbValue >> 8) & 0xFF
    let b = (rgbValue) & 0xFF
        
    return UIColor.init(red: CGFloat(Double(r)/255.0), green: CGFloat(Double(g)/255.0), blue: CGFloat(Double(b)/255.0), alpha: 1.0)
}

// MARK:-- 苹方字体的封装
func PingFangMedium(_ size: CGFloat) -> UIFont {
    guard let font =  UIFont(name: "PingFangSC-Medium", size: size) else {
        return UIFont.systemFont(ofSize: size)
    }
    return font
}

func PingFangRegular(_ size: CGFloat) -> UIFont {
    guard let font =  UIFont(name: "PingFangSC-Regular", size: size) else {
        return UIFont.systemFont(ofSize: size)
    }
    return font
}

// MARK:-- 图片使用的封装
public func ImageNamed(_ name:String)-> UIImage {
    guard let image = UIImage(named: name) else{
        return UIImage()
    }
    return image
}

public func FillImageNamed(_ name:String)-> UIImage {
    guard let image = UIImage(named: name)?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: UIImage.ResizingMode.stretch) else{
        return UIImage()
    }
    return image
}



// MARK:-- 常用的颜色
/// 状态栏选中字体颜色
public let tabbarFontNormalColor = RGBHex(0x8a8a8a)
/// 状态栏选中字体颜色
public let tabbarFontSelectColor = RGBHex(0x7792BB)

/// 导航栏阴影色
public let shadowImageColor = RGBHex(0xDDDDDD)
/// self.view的背景色
public let color_BgColor = RGBHex(0xFFFFFF)
/// 导航栏背景色
public let color_navigation = UIColor.white
/// 标题字体颜色 0x333333
public let color_title = RGBHex(0x333333)
/// 正文字体颜色 0x666666
public let color_normal = RGBHex(0x666666)
/// 辅助字体颜色 0x999999
public let color_assist = RGBHex(0x999999)
/// 系统默认分割线的颜色
public let color_sperator = RGBHex(0xDDDDDD)
/// 系列使用蓝色字体
public let color_main_blue = RGBHex(0x5a8ef5)
/// 系统使用红色字体
public let color_main_red = RGBHex(0xdf5757)
/// 系统使用黄色字体
public let color_main_yellow = RGBHex(0xFFBB28)



// MARK: -- 所有通知的名称

// MARK: -- 全局唯一图标字体
public let font_iconFont = "iconfont"

public let corner_radius = 6.0
