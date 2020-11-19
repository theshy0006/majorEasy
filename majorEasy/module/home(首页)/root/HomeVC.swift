//
//  HomeVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/28.
//

import UIKit
import ZCycleView
import SDWebImage
import Contacts

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
        
        requestContactAuthorAfterSystemVersion9()
    }
    
    override func setUpView() {
        self.navigationItem.title = "homeTitle".localized

        if let userRoleName = DataCenterManager.default.userInfo.userRoleName {
            self.setNavBarLeftBtn(normalText: "我是" + userRoleName, selector: #selector(popBack))
        } else {
            self.setNavBarLeftBtn(normalText: "我是管理员", selector: #selector(popBack))
        }
        self.setNavBarRightBtn(normalImage: "客服", selector: #selector(gotoForward))
        
        viewModel.checkVersion { [weak self] (model) in
            let versionCode = (model.value.iosVersionCode ?? "")
            if(Int(versionCode) ?? 0  > Int(LocalVersionCode) ?? 0) {
                self?.showUpdate(model.value.iosDescription ?? "")
            }
        } failure: { (error) in
            NBHUDManager.toast(error.message)
        }
    }
    
    func showUpdate(_ descirption: String) {
        
        if(description.count != 0) {
            let alertController = UIAlertController(title: "版本更新", message: descirption, preferredStyle: .alert) //
            let alertView1 = UIAlertAction(title: "确定", style: .default) { (UIAlertAction) -> Void in
                
                if let url = URL(string: "itms-apps://itunes.apple.com/app/id1541083779") {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: { (ist) in
                        })
                    }
                }
            }
             
           let alertView2 = UIAlertAction(title: "取消", style: .cancel) { (UIAlertAction) -> Void in
               }
           alertController.addAction(alertView1)
           alertController.addAction(alertView2)
           self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
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
    // 办证中心
    @IBAction func rushHallBtnPressed(_ sender: UIButton) {
        self.navigationController?.pushViewController(RushHallVC(), animated: true)
    }
    
    // 车辆临牌
    @IBAction func gotoPlateNumber(_ sender: UIButton) {
        self.navigationController?.pushViewController(PlatenumberVC(), animated: true)
    }

    // 优惠加油
    @IBAction func refuelBtnPressed(_ sender: UIButton) {
        
        let launchMiniProgramReq = WXLaunchMiniProgramReq.object()
        launchMiniProgramReq.userName = "gh_01e934dc87e6"
        launchMiniProgramReq.miniProgramType = .release
        WXApi.send(launchMiniProgramReq)
    }
    
    
    //手机管车
    @IBAction func carManagerPressed(_ sender: UIButton) {
        self.navigationController?.pushViewController(CarManagerVC(), animated: true)
    }
    // 买车
    @IBAction func buyCar(_ sender: Any) {
        self.navigationController?.pushViewController(BuyCarVC(), animated: true)
    }
    
    // 二手车
    @IBAction func buySecondCar(_ sender: Any) {
        self.navigationController?.pushViewController(SecondCarVC(), animated: true)
    }
    
    // 圈子
    @IBAction func gotoDriver(_ sender: Any) {
        self.navigationController?.pushViewController(DriversVC(), animated: true)
    }
    
    // 商城
    @IBAction func gotoShopVC(_ sender: Any) {
        self.navigationController?.pushViewController(ShopVC(), animated: true)
    }
    
    
    //我要找货
    @IBAction func searchBtnPressed(_ sender: UIButton) {
        self.navigationController?.pushViewController(SearchGoodsVC(), animated: true)
    }
    
    func requestContactAuthorAfterSystemVersion9() {

        let status: CNAuthorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
        if status == .notDetermined {
            let store = CNContactStore()
            store.requestAccess(for: .contacts, completionHandler: { granted, error in
                if error != nil {
                    print("授权失败")
                } else {
                    print("成功授权")
                }
            })
        } else if status == .restricted {
            print("用户拒绝")
            showAlertViewAboutNotAuthorAccessContact()
        } else if status == .denied {
            print("用户拒绝")
            showAlertViewAboutNotAuthorAccessContact()
        } else if status == .authorized {
            //有通讯录权限-- 进行下一步操作
            openContact()
        }

    }
    
    func showAlertViewAboutNotAuthorAccessContact() {
    }
    
    func openContact() {
        // 获取指定的字段,并不是要获取所有字段，需要指定具体的字段
        let keysToFetch = [
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactPhoneNumbersKey
        ]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch as [CNKeyDescriptor])
        let contactStore = CNContactStore()
        var addressBook = [Dictionary<String, String>]()
        do {
            try contactStore.enumerateContacts(with: fetchRequest, usingBlock: {(contact : CNContact, stop : UnsafeMutablePointer<ObjCBool>)-> Void in
                //拼接姓名
                let nameStr = "\(contact.familyName)\(contact.givenName)"
                let phoneNumbers = contact.phoneNumbers
                
                for labelValue in phoneNumbers {
                    let phoneNumber = labelValue.value as CNPhoneNumber
                    var string = phoneNumber.stringValue

                    //去掉电话中的特殊字符
                    string = string.replacingOccurrences(of: "+86", with: "")
                    string = string.replacingOccurrences(of: "-", with: "")
                    string = string.replacingOccurrences(of: "(", with: "")
                    string = string.replacingOccurrences(of: ")", with: "")
                    string = string.replacingOccurrences(of: " ", with: "")
                    string = string.replacingOccurrences(of: " ", with: "")

                    let dic = ["contactNumber":string,
                               "contactName":nameStr
                              ]
                    addressBook.append(dic);
                    
                }
            })
        } catch {
            print(error)
        }
        
        self.viewModel.addressBook(address:addressBook, success: { (model) in
        }) { (error) in
        }
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
