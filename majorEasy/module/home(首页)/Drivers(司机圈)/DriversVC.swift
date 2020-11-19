//
//  DriversVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/11/19.
//

import UIKit

class DriversVC: BaseVC {
    
    override func setUpView() {
        self.setNavBarRightBtn(normalText: "发布", selector: #selector(gotoForward))
        self.navigationItem.titleView = self.segmentVC.segmentBar;
        self.view.addSubview(self.segmentVC.view)
        self.segmentVC.setUpWithItems(["招聘","求职"], childVCs: [InviteVC(),ApplyVC()])
        self.segmentVC.segmentBar.update(config: { config in
            let _ = config?.itemNormalColor(UIColor.init(red: CGFloat(Double(0x33)/255.0), green: CGFloat(Double(0x33)/255.0), blue: CGFloat(Double(0x33)/255.0), alpha: 0.7))?.itemSelectColor(tabbarFontSelectColor)?.indicatorColor(tabbarFontSelectColor)?
                .itemFont(PingFangRegular(16))?.indicatorExtraW(0)
        })
    }
    
    lazy var segmentVC = LLSegmentBarVC().then {
        $0.segmentBar.frame = CGRect(x: 0, y: 40, width: 300, height: 42)
        $0.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
        self.addChild($0)
    }
    
    override func gotoForward() {
        
    }

}
