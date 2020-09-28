//
//  NBCovorEnum.swift
//  NoteBook
//
//  Created by dede wang on 2019/10/20.
//  Copyright © 2019 com.boc. All rights reserved.
//

import UIKit

/** 默认动画时间 */
let kAnimDuration = 0.25
/** 默认透明度 */
let kAlpha = 0.5

/** 视图显示类型 */
enum NBCovorStyle {
    /** 半透明 */
    case translucent  // 半透明
    /** 全透明 */
    case transparent  // 全透明
    /** 高斯模糊 */
    case blur          // 高斯模糊
}

/** 动画类型 */
enum NBCoverAnimStyle {
    case top      // 从上弹出 (上，中可用)
    case center   // 中间弹出 (中可用)
    case bottom   // 底部弹出,底部消失 (中，下可用)
    case left     // 左侧弹出,左侧消失
    case right    // 右侧弹出,右侧消失
    case none      // 无动画
}
