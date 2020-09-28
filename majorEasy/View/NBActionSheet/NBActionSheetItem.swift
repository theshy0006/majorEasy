//
//  NBActionSheetItem.swift
//  acorn
//
//  Created by dede on 2019/3/14.
//  Copyright © 2019 dede. All rights reserved.
//

import UIKit

@objc class NBActionSheetItem : NSObject {
    var image: UIImage?
@objc var imageName: String?
    var tagImgName: String?
@objc var title: String = ""
@objc var tag: String = ""
    var enabled: Bool = true
    var clickBlock:(()->())?
}

/* 测试用例
 func test() {
     let item1 = NBActionSheetItem()
     let item2 = NBActionSheetItem()
     let item3 = NBActionSheetItem()
     let item4 = NBActionSheetItem()
     let item5 = NBActionSheetItem()
     let item6 = NBActionSheetItem()
 
     item1.imageName = "cm2_lay_icn_next_new"
     item1.title   = "下一首播放"
 
     item2.imageName = "cm2_lay_icn_share_new"
     item2.title   = "分享"
 
     item3.imageName = "cm2_lay_icn_dld_new"
     item3.title   = "下载"
     
     item4.imageName = "cm2_lay_icn_cmt_new"
     item4.title   = "评论"
 
     item5.imageName = "cm2_lay_icn_cmt_new"
     item5.title   = "歌手：某某"
 
     item6.imageName = "cm2_lay_icn_alb_new"
     item6.title   = "专辑：逃离地球 "
 
     NBActionSheet.showActionSheet(title: "尼玛的", itemInfos: [item1, item2, item3, item4, item5, item6], callBack: { (row, item) -> () in
     print(row)
     print(item)
     })
 }
 */
