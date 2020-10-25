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
        
        viewModel.getShareUrl( success: {
            
        }) { (error) in
            NBHUDManager.toast(error.message)
        }

        BaiduMapManager.shared().startUpdatingLocation()
        
        // 定位成功后的回调
        BaiduMapManager.shared().locationSuccess = {
            let lat = "\(BaiduMapManager.shared().userLocation.location.coordinate.latitude)"
            let lng = "\(BaiduMapManager.shared().userLocation.location.coordinate.longitude)"
            print(lat)
            print(lng)
        }
    }
    
    override func setUpView() {
        self.navigationItem.title = "homeTitle".localized
        
        if let userRoleName = DataCenterManager.default.userInfo.userRoleName {
            self.setNavBarLeftBtn(normalText: "我是" + userRoleName, selector: #selector(popBack))
        }
        
        
       
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
        NBUtility.showTelephone()
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
    
    //我要找货
    @IBAction func searchBtnPressed(_ sender: UIButton) {
        self.navigationController?.pushViewController(SearchGoodsVC(), animated: true)
    }
    
    
    @IBAction func shareBtnPressed(_ sender: UIButton) {
        NBShareView.showTips { index in
            print(index)
            
            if( index == 0 ) {
                // 朋友圈
                ShareManager.shareInstance().shareWeChatFriend("大件无忧，询价调车更迅速", andContent: "邀请朋友下载大件无忧可以获取跨省大件免费办理办证! 注册奖励100元!邀请好友奖励50元!邀请每个用户都会 成为你2级会员，他们邀请朋友注册也可以获取30元奖励 想要永久免费办理跨省大件运输证，请粉享您的朋友圈", image: "", linkWith: DataCenterManager.default.shareUrl, shareType: .WECHATZONE, style: .cargo)
            } else {
                // 微信好友
                ShareManager.shareInstance().shareWeChatFriend("大件无忧，询价调车更迅速", andContent: "邀请朋友下载大件无忧可以获取跨省大件免费办理办证! 注册奖励100元!邀请好友奖励50元!邀请每个用户都会 成为你2级会员，他们邀请朋友注册也可以获取30元奖励 想要永久免费办理跨省大件运输证，请粉享您的朋友圈", image: "", linkWith: DataCenterManager.default.shareUrl, shareType: .WECHAT, style: .cargo)
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
