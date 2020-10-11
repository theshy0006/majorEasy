//
//  HomeVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/28.
//

import UIKit
import ZCycleView
import SDWebImage

class HomeVC: BaseVC {
    let viewModel = HomeViewModel()
    @IBOutlet weak var bannerView: UIView!
    var cycleView:ZCycleView!
    
    override func setUpData() {
        NBLoadManager.showLoading()
        viewModel.getHomeImages( success: {[weak self] (model) in
            guard let weakSelf = self else {return}
            NBLoadManager.hidLoading()
            weakSelf.viewModel.images = model.value.carouselimages
            weakSelf.initBanner()
        }) {[weak self] (error) in
            guard let weakSelf = self else {return}
            NBLoadManager.hidLoading()
            weakSelf.initBanner()
            NBHUDManager.toast(error.message)
        }
    }
    
    override func setUpView() {
        self.navigationItem.title = "homeTitle".localized
        self.setNavBarLeftBtn(normalText: "我是车主", selector: #selector(popBack))
        self.setNavBarRightBtn(normalImage: "客服", selector: #selector(gotoForward))
 
    }
    
    func initBanner() {
        self.cycleView = ZCycleView(frame: CGRect(x: 0, y: 0, width: bannerView.width, height: bannerView.height))
        self.cycleView.placeholderImage = ImageNamed("placeholder")
        cycleView.setUrlsGroup(self.viewModel.images)
        cycleView.delegate = self
        bannerView.addSubview(cycleView)
    }
    
    //点击导航栏右侧按钮事件
    @objc override func gotoForward(){
        NBUtility.showTelephone(self)
    }
    
    //专线查询
    @IBAction func specialBtnPressed(_ sender: UIButton) {
        self.navigationController?.pushViewController(SpecialLineVC(), animated: true)
    }
    
    //发货调车
    @IBAction func shuntBtnPressed(_ sender: UIButton) {
        self.navigationController?.pushViewController(ShuntVC(), animated: true)
    }
    //手机管车
    @IBAction func carManagerPressed(_ sender: UIButton) {
        self.navigationController?.pushViewController(CarManagerVC(), animated: true)
    }
    
    @IBAction func shareBtnPressed(_ sender: UIButton) {
        NBShareView.showTips { index in
            print(index)
            
            if( index == 0 ) {
                // 朋友圈
                ShareManager.shareInstance().shareWeChatFriend("测试的呀", andContent: "加油加油加油", image: "", linkWith: "https://www.baidu.com", shareType: .WECHATZONE, style: .cargo)
            } else {
                // 微信好友
            }
        }
    }
    

}

extension HomeVC: ZCycleViewProtocol{
    func cycleViewConfigureDefaultCellImageUrl(_ cycleView: ZCycleView, imageView: UIImageView, imageUrl: String?, index: Int) {
        if let url = imageUrl {
            let url = URL(string: url)
            imageView.sd_setImage(with: url, placeholderImage: cycleView.placeholderImage)
        } else {
            imageView.image = ImageNamed("placeholder")
        }
    }
    func cycleViewConfigurePageControl(_ cycleView: ZCycleView, pageControl: ZPageControl) {
        pageControl.pageIndicatorTintColor = tabbarFontNormalColor
        pageControl.currentPageIndicatorTintColor = UIColor.white
    }
}
