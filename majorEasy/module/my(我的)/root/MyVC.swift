//
//  MyVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/29.
//

import UIKit

class MyVC: BaseVC {

    //余额
    @IBOutlet weak var balanceLabel: UILabel!
    //邀请奖励
    @IBOutlet weak var integralLabel: UILabel!
    //充值奖励
    @IBOutlet weak var rechargeReward: UILabel!
    
    @IBOutlet weak var headImageView: UIImageView!
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var moneyView: UIView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var toolView: UIView!
    @IBOutlet weak var headerView: UIView!
    
    let viewModel = MyViewModel()
    
    @IBAction func gotoSetting(_ sender: UIButton) {
        self.navigationController?.pushViewController(SettingVC(), animated: true)
    }

    override func setUpData() {
        
    }
    
    override func setUpView() {
        headerView.layer.cornerRadius = 30
        self.view.backgroundColor = RGBHex(0xF6F6F6)
        self.hideNavigationBar = true
        self.moneyView.addShadow(RGBHex(0xe2e2e2))
        self.messageView.addShadow(RGBHex(0xe2e2e2))
        self.toolView.addShadow(RGBHex(0xe2e2e2))
        self.statusLabel.isHidden = true
        
        self.statusLabel.layer.cornerRadius = 4
        topView.snp.updateConstraints { (make) -> Void in
            make.height.equalTo(162+StatusHeight)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getUserInfo { [weak self] in
            self?.resetUI()
        } failure: { (error) in
            NBHUDManager.toast(error.message)
        }

    }
    
    func resetUI() {
        self.statusLabel.isHidden = false
        if (DataCenterManager.default.myInfo.idReview == 1) {
            self.statusLabel.text = "  已审核  "
        } else if (DataCenterManager.default.myInfo.idReview == 0) {
            self.statusLabel.text = "  未审核  "
        } else {
            self.statusLabel.text = "  审核中  "
        }
        self.balanceLabel.text = String(format:"%.2f",DataCenterManager.default.myInfo.balance)
        self.integralLabel.text = String(format:"%.2f",DataCenterManager.default.myInfo.integral)
        self.rechargeReward.text = String(format:"%.2f",DataCenterManager.default.myInfo.rechargeReward)
        self.userLabel.text = DataCenterManager.default.myInfo.userName
        self.phoneLabel.text = DataCenterManager.default.myInfo.phoneNumber
        
        if let url = DataCenterManager.default.myInfo.headPortraitUrl {
            let url = URL(string: url)
            self.headImageView.sd_setImage(with: url, placeholderImage: ImageNamed("编组"))
        } else {
            self.headImageView.image = ImageNamed("编组")
        }
    }
    
    @IBAction func headPressed(_ sender: UIButton) {
        self.navigationController?.pushViewController(PersonalVC(), animated: true)
    }
    
    @IBAction func gotoGoodsOwenr(_ sender: UIButton) {
        if (DataCenterManager.default.myInfo.idReview == 0) {
            self.navigationController?.pushViewController(GoodsOwenrVC(), animated: true)
        } else if (DataCenterManager.default.myInfo.idReview == 1) {
            NBHUDManager.toast("已审核")
        } else {
            NBHUDManager.toast("审核中")
        }
    }
    
    @IBAction func gotoInvite(_ sender: UIButton) {
        self.navigationController?.pushViewController(TopTenTV.init(type: 0), animated: true)
    }
    
    @IBAction func gotoAward(_ sender: UIButton) {
        self.navigationController?.pushViewController(TopTenTV.init(type: 1), animated: true)
    }
    
    @IBAction func gotoRecharge(_ sender: UIButton) {
        self.navigationController?.pushViewController(TopTenTV.init(type: 2), animated: true)
    }
    
    @IBAction func gotoShare(_ sender: UIButton) {
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

    @IBAction func logout(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: "确定退出登录？", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "取消", style: .default, handler:nil)
        let okAction = UIAlertAction(title: "确认", style: .default, handler: {
            (ac) in
            DataCenterManager.default.clear()
            kAppdelegate.setUpLoginVC()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    

}


