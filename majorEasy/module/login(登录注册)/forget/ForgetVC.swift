//
//  ForgetVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/27.
//

import UIKit

class ForgetVC: BaseVC {
    @IBOutlet weak var phoneView: NBOneEdgeView!
    @IBOutlet weak var codeView: NBOneEdgeView!
    @IBOutlet weak var passwordView: NBOneEdgeView!
    @IBOutlet weak var sureView: NBOneEdgeView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var commitButton: UIButton!
    
    var tpyeName = ""
    
    let viewModel = ForgetViewModel()
    
    lazy var phoneField = NBBottomWarningTextFieldView(placeholderString: "请输入手机号码", textColor: color_normal, font: nil, isSecureTextEntry: nil, redString: "", redFont: nil).then {
        $0.textField.keyboardType = .numberPad
        $0.maxLength = 11
        $0.text = ""
        $0.backgroundColor = .white
        $0.textFieldDelegate = self
        $0.redLabel.isHidden = false
    }
    
    lazy var codeField = NBBottomWarningTextFieldView(placeholderString: "请输入验证码", textColor: color_normal, font: nil, isSecureTextEntry: nil, redString: "", redFont: nil).then {
        $0.textField.keyboardType = .numberPad
        $0.maxLength = 6
        $0.text = ""
        $0.backgroundColor = .white
        $0.textFieldDelegate = self
        $0.redLabel.isHidden = false
    }
    
    lazy var passwordField = NBBottomWarningTextFieldView(placeholderString: "请输入6-12位新密码，字母或数字", textColor: color_normal, font: nil, isSecureTextEntry: "true", redString: "", redFont: nil).then {
        $0.textField.keyboardType = .default
        $0.maxLength = 12
        $0.text = ""
        $0.backgroundColor = .white
        $0.textFieldDelegate = self
        $0.redLabel.isHidden = false
    }
    
    lazy var sureField = NBBottomWarningTextFieldView(placeholderString: "请再次输入新密码", textColor: color_normal, font: nil, isSecureTextEntry: "true", redString: "", redFont: nil).then {
        $0.textField.keyboardType = .default
        $0.maxLength = 12
        $0.text = ""
        $0.backgroundColor = .white
        $0.textFieldDelegate = self
        $0.redLabel.isHidden = false
    }

    override func setUpData() {
        self.sendButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let weakself = self else {
                return
            }
            weakself.getSmsCode(mobile: weakself.phoneField.text)
        }).disposed(by: disposeBag)
    }
    
    override func setUpView() {
        
        if (tpyeName.count != 0) {
            self.navigationItem.title = tpyeName
        } else {
            self.navigationItem.title = "forget".localized
        }
        
        self.commitButton.addShadow(RGBHex(0xe2e2e2))
        self.phoneView.addSubview(self.phoneField)
        self.codeView.addSubview(self.codeField)
        self.passwordView.addSubview(self.passwordField)
        self.sureView.addSubview(self.sureField)
        
        self.phoneField.snp.makeConstraints { (make) -> Void in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        self.codeField.snp.makeConstraints { (make) -> Void in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview().offset(-100)
            make.height.equalTo(50)
        }
        self.passwordField.snp.makeConstraints { (make) -> Void in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        self.sureField.snp.makeConstraints { (make) -> Void in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    // 获取验证码
    func getSmsCode(mobile:String?) {
        self.phoneField.redLabel.isHidden = false
        guard let tel = mobile else {
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

        NBLoadManager.showLoading()
        self.viewModel.getSmsCode(mobile: tel, success: {[weak self] (model) in
            self?.updateValidateCodeView()
            NBLoadManager.hidLoading()
            NBHUDManager.toast(model.message ?? "")
        }) { (error) in
            NBLoadManager.hidLoading()
            NBHUDManager.toast(error.message)
        }
    }
    
    func updateValidateCodeView(){
        let countDown = NBCountDown(codeBtn: self.sendButton)
        countDown.isCounting = true //开启倒计时
    }
    
    @IBAction func resetPassword(_ sender: Any) {
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
        
        codeField.redLabel.isHidden = false
        if (codeField.text?.count == 0) {
            codeField.redString = "请输入验证码"
            return
        } else {
            codeField.redString = ""
            self.codeField.redLabel.isHidden = true
        }
        
        passwordField.redLabel.isHidden = false
        if (passwordField.text?.count ?? 0 < 6 || passwordField.text?.count ?? 0 > 12) {
            passwordField.redString = "请输入6-12位中英文密码"
            return
        } else {
            passwordField.redString = ""
            self.passwordField.redLabel.isHidden = true
        }
        
        sureField.redLabel.isHidden = false
        if (sureField.text?.count ?? 0 < 6 || sureField.text?.count ?? 0 > 12) {
            sureField.redString = "请再输入一遍密码"
            return
        } else if (sureField.text != passwordField.text){
            sureField.redString = "两次密码不一致"
            return
        } else {
            sureField.redString = ""
            self.sureField.redLabel.isHidden = true
        }
        
        NBLoadManager.showLoading()
        //提交
        viewModel.resetPassword(mobile: phoneField.text ?? "", Invite_code: passwordField.text ?? "", smsCode: codeField.text ?? "", success: {[weak self](model) in
            NBLoadManager.hidLoading()
            NBHUDManager.toast(model.message ?? "")
            self?.popBack()
        }) { (error) in
            NBLoadManager.hidLoading()
            NBHUDManager.toast(error.message)
        }
        
        
    }

}

extension ForgetVC: NBBottomWarningTextFieldDelegate {
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
        } else if (textFieldView == self.codeField) {
            textFieldView.redLabel.isHidden = false
            
            if (textFieldView.text?.count == 0) {
                textFieldView.redString = "请输入验证码"
            } else {
                textFieldView.redString = ""
                
            }
        } else if (textFieldView == self.passwordField) {
            textFieldView.redLabel.isHidden = false
            
            if (textFieldView.text?.count ?? 0 < 6 || textFieldView.text?.count ?? 0 > 12) {
                textFieldView.redString = "请输入6-12位中英文密码"
            } else {
                textFieldView.redString = ""
                
            }
        } else if (textFieldView == self.sureField) {
            textFieldView.redLabel.isHidden = false
            
            if (textFieldView.text?.count == 0) {
                textFieldView.redString = "请再输入一遍密码"
            } else {
                textFieldView.redString = ""
                
            }
        }
        
    }
}
