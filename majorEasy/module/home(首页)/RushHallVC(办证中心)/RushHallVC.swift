//
//  RushHallVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/11/6.
//

import UIKit

class RushHallVC: BaseVC {

    let viewModel = RushHallViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "大件无忧办证中心"
        // Do any additional setup after loading the view.
        
        WXApiManager.shared()?.delegate = self
        
        NBLoadManager.showLoading()
        viewModel.getCertificate {
            NBLoadManager.hidLoading()
        } failure: { (error) in
            NBLoadManager.hidLoading()
            NBHUDManager.toast(error.message)
        }
        
        getUserInfo()
    }
    
    @IBAction func buttonOnePressed(_ sender: Any) {
        gotoMain(index:0)
    }
    
    @IBAction func buttonTwoPressed(_ sender: Any) {
        gotoMain(index:1)
    }
    
    @IBAction func buttonThreePressed(_ sender: Any) {
        gotoMain(index:2)
    }
    
    @IBAction func buttonFourPressed(_ sender: Any) {
        gotoMain(index:3)
    }
    
    func gotoMain(index:Int) {
        PayWayView.showPayWay(callBack: {[weak self] (item) -> () in
            print(item)
            self?.mainFunc(item: item, index: index)
        })
    }
    
    func getUserInfo() {
        viewModel.getUserInfo {
            
        } failure: { (error) in
            NBHUDManager.toast(error.message)
        }
    }
    
    func mainFunc(item: PayWayModel, index: Int) {
        let model = self.viewModel.dataSource[index]
        if (item.name == "余额支付") {
            NBLoadManager.showLoading()
            viewModel.balanceMain(certId: model.id, integral: 0, price: model.price, paymentWay: 1) { [weak self] model in
                NBLoadManager.hidLoading()
                self?.showSuccess(message:model.message ?? "")
                self?.getUserInfo()
            } failure: { (error) in
                NBHUDManager.hidLoading()
                NBHUDManager.toast(error.message)
            }
        } else if (item.name == "微信支付") {
            NBLoadManager.showLoading()
            viewModel.balanceMain(certId: model.id, integral: 0, price: model.price, paymentWay: 2) { [weak self] model in
                NBLoadManager.hidLoading()
                self?.wxPay(model: model.value)
            } failure: { (error) in
                NBLoadManager.hidLoading()
                NBHUDManager.toast(error.message)
            }
        }

    }
    
    func wxPay(model: WeixinPay) {
        let req = PayReq()
        //由用户微信号和AppID组成的唯一标识，用于校验微信用户
        req.openID = model.appid ?? ""
        
        // 商家id，在注册的时候给的
        req.partnerId = model.partnerid ?? ""
        
        // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
        req.prepayId  = model.prepayid ?? ""
        
        // 根据财付通文档填写的数据和签名
        //这个比较特殊，是固定的，只能是即req.package = Sign=WXPay
        req.package   = model.package ?? ""
        
        // 随机编码，为了防止重复的，在后台生成
        req.nonceStr  = model.noncestr ?? ""
        
        // 这个是时间戳，也是在后台生成的，为了验证支付的
        let stamp = model.timestamp ?? ""
        req.timeStamp = UInt32(stamp) ?? 0;
        
        // 这个签名也是后台做的
        req.sign = model.sign ?? ""
        
        //发送请求到微信，等待微信返回onResp
        WXApi.send(req)
        
    }
    
    func showSuccess(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "确定", style: .default, handler:nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }

}

extension RushHallVC: WXApiManagerDelegate {
    func managerDidRecvWechatPayResponse(_ response: PayResp!) {
        if (response.errCode == 0) {
            showSuccess(message: "支付成功")
            self.getUserInfo()
        } else if (response.errCode == -2) {
            showSuccess(message: "取消支付")
        } else {
            showSuccess(message: "支付失败")
        }
    }
}

