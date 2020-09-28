//
//  LoginVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/27.
//

import UIKit

class LoginVC: BaseVC {

    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var passwordLine: UIView!
    @IBOutlet weak var userLine: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var phoneIcon: UIImageView!
    @IBOutlet weak var codeIcon: UIImageView!
    @IBOutlet weak var forgetBtn: UIButton!
    @IBOutlet weak var agreeButton: UIButton!
    
    let viewModel = LoginViewModel()
    
    lazy var phoneField = NBBottomWarningTextFieldView(placeholderString: "请输入手机号码", textColor: color_normal, font: nil, isSecureTextEntry: nil, redString: "", redFont: nil).then {
        $0.textField.keyboardType = .numberPad
        $0.maxLength = 11
        $0.text = ""
        $0.backgroundColor = .white
        $0.textFieldDelegate = self
        $0.redLabel.isHidden = false
    }

    lazy var passwordField = NBBottomWarningTextFieldView(placeholderString: "请输入登录密码", textColor: color_normal, font: nil, isSecureTextEntry: "true", redString: nil, redFont: nil).then {
        $0.text = ""
        $0.textField.keyboardType = .default
        $0.maxLength = 12
        $0.backgroundColor = .white
        $0.textFieldDelegate = self
        $0.redLabel.isHidden = false
    }
    
    override func setUpData() {
        self.hideNavigationBar = true
    }
    
    override func setUpView() {
        self.loginBtn.addShadow(RGBHex(0xe2e2e2))
        self.agreeButton.setImage(ImageNamed("uncheck"), for: .normal)
        self.agreeButton.setImage(ImageNamed("check"), for: .selected)
        self.view.addSubview(self.phoneField)
        self.view.addSubview(self.passwordField)
        
        self.phoneField.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.userLine.snp.top).offset(-1)
            make.left.right.equalToSuperview().inset(48)
            make.height.equalTo(50)
        }
        
        self.passwordField.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.bottom.equalTo(passwordLine.snp.top).offset(-1)
            make.left.equalToSuperview().offset(48)
            make.right.equalTo(self.forgetBtn.snp.left)
        }
    }

    @IBAction func agreeBtnPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    
    @IBAction func login(_ sender: UIButton) {
        if(!self.agreeButton.isSelected) {
            NBHUDManager.toast("请阅读并同意用户协议")
            return
        }

        self.phoneField.redLabel.isHidden = false
        if (phoneField.text?.count == 0) {
            phoneField.redString = "请输入手机号"
            return
        }
        if (phoneField.text?.count != 11) {
            phoneField.redString = "请输入11位手机号码"
            return
        } else if (!NBUtility.regularPhoneNo(phoneField.text ?? "")) {
            phoneField.redString = "手机号格式不正确"
            return
        } else {
            phoneField.redString = ""
            self.phoneField.redLabel.isHidden = true
        }
        
        passwordField.redLabel.isHidden = false
        if (passwordField.text?.count == 0) {
            passwordField.redString = "请输入密码"
            return
        } else {
            passwordField.redString = ""
            self.passwordField.redLabel.isHidden = true
        }
        
        NBLoadManager.showLoading()
        viewModel.loginIn(mobile: phoneField.text ?? "", smsCode: passwordField.text ?? "", success: {(model) in
           NBLoadManager.hidLoading()
           kAppdelegate.setUpTabBar()
           NBHUDManager.toast(model.message ?? "")
        }) { (error) in
           NBLoadManager.hidLoading()
           NBHUDManager.toast(error.message)
        }
    }
    
    @IBAction func forget(_ sender: UIButton) {
        self.navigationController?.pushViewController(ForgetVC(), animated: true)
    }
    
    @IBAction func register(_ sender: UIButton) {
        self.navigationController?.pushViewController(RegisterVC(), animated: true)
    }
    
    
    @IBAction func gotoServe(_ sender: UIButton) {
        let model:ProtocolModel = ProtocolModel()
        model.title = "service".localized
        model.contentUrl = servicePath
        
        self.navigationController?.pushViewController(SimpleWebView(protocolModel: model), animated: true)
    }
    
    @IBAction func gotoPrivacy(_ sender: UIButton) {
        let model:ProtocolModel = ProtocolModel()
        model.title = "privacy".localized
        model.contentUrl = privacePath
        
        self.navigationController?.pushViewController(SimpleWebView(protocolModel: model), animated: true)
    }
    
    @IBAction func goToAccredit(_ sender: UIButton) {
        let model:ProtocolModel = ProtocolModel()
        model.title = "accredit".localized
        model.contentUrl = accreditPath
        
        self.navigationController?.pushViewController(SimpleWebView(protocolModel: model), animated: true)
    }
}

extension LoginVC: NBBottomWarningTextFieldDelegate {
    func NBBottomWarningTextFieldDidEndEditing(text: String?, textFieldView: NBBottomWarningTextFieldView) {
        if (textFieldView == self.phoneField) {
            textFieldView.redLabel.isHidden = false
            if (textFieldView.text?.count != 11) {
                textFieldView.redString = "请输入11位手机号码"
            } else if (!NBUtility.regularPhoneNo(textFieldView.text ?? "")) {
                textFieldView.redString = "手机号格式不正确"
            } else {
                textFieldView.redString = ""
            }
        } else if (textFieldView == self.passwordField) {
            textFieldView.redLabel.isHidden = false
            
            if (textFieldView.text?.count == 0) {
                textFieldView.redString = "请输入登录密码"
            } else {
                textFieldView.redString = ""
                
            }
        }
    }

}
