//
//  PostVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/24.
//

import UIKit

class PostVC: BaseVC {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var offenButton: UIButton!
    @IBOutlet weak var agreeButton: UIButton!
    
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var toButton: UIButton!
    
    @IBOutlet weak var goodsButton: UIButton!
    @IBOutlet weak var lengthButton: UIButton!
    @IBOutlet weak var specificationButton: UIButton!
    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var typeButton: UIButton!
    @IBOutlet weak var timeButton: UIButton!
    
    var fromCity = ""
    var fromCityDetail = ""
    var fromCityId = ""
    
    var toCity = ""
    var toCityDetail = ""
    var toCityId = ""
    
    var inputModel = MakeInputModel()
    var suppliesInfo = MySuppliesInfo()
    convenience init(suppliesInfo: MySuppliesInfo) {
        self.init()
        self.suppliesInfo = suppliesInfo
    }

    lazy var fromField = NBBottomWarningTextFieldView(placeholderString: "城市/区域", textColor: color_normal, font: nil, isSecureTextEntry: nil, redString: "", redFont: nil).then {
        $0.textField.keyboardType = .default
        $0.text = ""
        $0.backgroundColor = .white
        $0.textFieldDelegate = self
        $0.redLabel.isHidden = false
    }
    
    lazy var fromAddressField = NBBottomWarningTextFieldView(placeholderString: "选填，请输入详细地址", textColor: color_normal, font: nil, isSecureTextEntry: nil, redString: "", redFont: nil).then {
        $0.textField.keyboardType = .default
        $0.text = ""
        $0.backgroundColor = .white
        $0.textFieldDelegate = self
        $0.redLabel.isHidden = false
    }
    
    lazy var toField = NBBottomWarningTextFieldView(placeholderString: "城市/区域", textColor: color_normal, font: nil, isSecureTextEntry: nil, redString: "", redFont: nil).then {
        $0.textField.keyboardType = .default
        $0.text = ""
        $0.backgroundColor = .white
        $0.textFieldDelegate = self
        $0.redLabel.isHidden = false
    }
    
    lazy var toAddressField = NBBottomWarningTextFieldView(placeholderString: "选填，请输入详细地址", textColor: color_normal, font: nil, isSecureTextEntry: nil, redString: "", redFont: nil).then {
        $0.textField.keyboardType = .default
        $0.text = ""
        $0.backgroundColor = .white
        $0.textFieldDelegate = self
        $0.redLabel.isHidden = false
    }
    
    lazy var goodsField = NBBottomWarningTextFieldView(placeholderString: "请输入货物信息", textColor: color_normal, font: nil, isSecureTextEntry: nil, redString: "", redFont: nil).then {
        $0.textField.keyboardType = .default
        $0.text = ""
        $0.backgroundColor = .white
        $0.textFieldDelegate = self
        $0.redLabel.isHidden = false
    }
    
    lazy var lengthField = NBBottomWarningTextFieldView(placeholderString: "请输入车型车长", textColor: color_normal, font: nil, isSecureTextEntry: nil, redString: "", redFont: nil).then {
        $0.textField.keyboardType = .default
        $0.text = ""
        $0.backgroundColor = .white
        $0.textFieldDelegate = self
        $0.redLabel.isHidden = false
    }
    
    lazy var specificationField = NBBottomWarningTextFieldView(placeholderString: "选填，请填写货物规格", textColor: color_normal, font: nil, isSecureTextEntry: nil, redString: "", redFont: nil).then {
        $0.textField.keyboardType = .default
        $0.text = ""
        $0.backgroundColor = .white
        $0.textFieldDelegate = self
        $0.redLabel.isHidden = false
    }
    
    lazy var priceField = NBBottomWarningTextFieldView(placeholderString: "选填", textColor: color_normal, font: nil, isSecureTextEntry: nil, redString: "", redFont: nil).then {
        $0.textField.keyboardType = .default
        $0.text = ""
        $0.backgroundColor = .white
        $0.textFieldDelegate = self
        $0.redLabel.isHidden = false
    }
    
    lazy var typeField = NBBottomWarningTextFieldView(placeholderString: "", textColor: color_normal, font: nil, isSecureTextEntry: nil, redString: "", redFont: nil).then {
        $0.textField.keyboardType = .default
        $0.text = "一装一卸"
        $0.backgroundColor = .white
        $0.textFieldDelegate = self
        $0.redLabel.isHidden = false
    }
    
    lazy var timeField = NBBottomWarningTextFieldView(placeholderString: "请选择时间", textColor: color_normal, font: nil, isSecureTextEntry: nil, redString: "", redFont: nil).then {
        $0.textField.keyboardType = .default
        $0.text = ""
        $0.backgroundColor = .white
        $0.textFieldDelegate = self
        $0.redLabel.isHidden = false
    }
    
    //选择城市控件
    lazy var chooseAreaView = NBCitySelectView(frame: CGRect(x: 0, y: kScreenH/4, width: kScreenW, height: 3*kScreenH/4 - SafeAreaBottomHeight - TabBarHeight)).then {
        $0.backgroundColor = .white
    }
    
    override func setUpData() {
        
    }
    
    override func setUpView() {
        topView.addShadow(RGBHex(0xe2e2e2))
        centerView.addShadow(RGBHex(0xe2e2e2))
        self.navigationItem.title = "post".localized
        topView.addSubview(fromField)
        topView.addSubview(fromAddressField)
        topView.addSubview(toField)
        topView.addSubview(toAddressField)
        
        centerView.addSubview(goodsField)
        centerView.addSubview(lengthField)
        centerView.addSubview(specificationField)
        centerView.addSubview(priceField)
        centerView.addSubview(typeField)
        centerView.addSubview(timeField)
        
        topView.bringSubviewToFront(upButton)
        topView.bringSubviewToFront(toButton)

        centerView.bringSubviewToFront(goodsButton)
        centerView.bringSubviewToFront(lengthButton)
        centerView.bringSubviewToFront(specificationButton)
        centerView.bringSubviewToFront(typeButton)
        centerView.bringSubviewToFront(timeButton)
        
        fromField.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(44)
            make.height.equalTo(44)
        }
        fromAddressField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(fromField.snp.bottom).offset(1)
            make.left.right.equalToSuperview().inset(44)
            make.height.equalTo(44)
        }
        toField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(fromAddressField.snp.bottom).offset(1)
            make.left.right.equalToSuperview().inset(44)
            make.height.equalTo(44)
        }
        toAddressField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(toField.snp.bottom).offset(1)
            make.left.right.equalToSuperview().inset(44)
            make.height.equalTo(44)
        }
        
        // center
        goodsField.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-44)
            make.left.equalToSuperview().offset(88)
            make.height.equalTo(50)
        }
        lengthField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(goodsField.snp.bottom).offset(1)
            make.right.equalToSuperview().offset(-44)
            make.left.equalToSuperview().offset(88)
            make.height.equalTo(50)
        }
        specificationField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(lengthField.snp.bottom).offset(1)
            make.right.equalToSuperview().offset(-44)
            make.left.equalToSuperview().offset(88)
            make.height.equalTo(50)
        }
        priceField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(specificationField.snp.bottom).offset(1)
            make.right.equalToSuperview().offset(-44)
            make.left.equalToSuperview().offset(88)
            make.height.equalTo(50)
        }
        typeField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(priceField.snp.bottom).offset(1)
            make.right.equalToSuperview().offset(-44)
            make.left.equalToSuperview().offset(88)
            make.height.equalTo(50)
        }
        timeField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(typeField.snp.bottom).offset(1)
            make.right.equalToSuperview().offset(-44)
            make.left.equalToSuperview().offset(88)
            make.height.equalTo(50)
        }
        
    }
    
    @IBAction func offenButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func agreeButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func fromButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        self.chooseAreaView.show()
        chooseAreaView.myColsure = { [weak self] (cityName, cityId) in
            print(cityName)
            print(cityId)
            self?.fromCity = cityName;
            self?.fromCityId = cityId;
            self?.fromField.text = cityName;
        }
    }
    
    @IBAction func toButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        self.chooseAreaView.show()
        chooseAreaView.myColsure = { [weak self] (cityName, cityId) in
            print(cityName)
            print(cityId)
            self?.toCity = cityName;
            self?.toCityId = cityId;
            self?.toField.text = cityName;
        }
    }
    
    @IBAction func goodsButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        let vc = GoodsTypeVC()
        vc.myColsure = { [weak self] (name, packType, minHeight, maxHeight, minVolume, maxVolume) in
            let title = name + "/" + packType + "/" + minHeight + "~" + maxHeight + "吨" + "/"  + minVolume + "~" + maxVolume
            + "方"
            self?.goodsField.text = title
        }
        self.present(vc, animated: true)
    }
    @IBAction func lengthsButtonPressed(_ sender: UIButton) {
        let vc = CarTypeVC()
        vc.myColsure = { [weak self] (type, cartype, length, height) in
            var title = ""
            title = type + "/" + cartype + "/" + length + "/" + height
            self?.lengthField.text = title
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func specificationButtonPressed(_ sender: UIButton) {
        let vc = GoodStandardVC()
        vc.myColsure = { [weak self] (length, width, height, diameter, remark) in
            var title = ""
            title = "长\(length)宽\(width)高\(height)直径\(diameter)"
            self?.specificationField.text = title
        }
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func typeButtonPressed(_ sender: UIButton) {
    }
    @IBAction func timeButtonPressed(_ sender: UIButton) {
    }
}

extension PostVC: NBBottomWarningTextFieldDelegate {
    func NBBottomWarningTextFieldDidEndEditing(text: String?, textFieldView: NBBottomWarningTextFieldView) {
        if (textFieldView == self.fromField) {
            textFieldView.redLabel.isHidden = false
            if (textFieldView.text?.count == 0) {
                textFieldView.redString = "请选择装货地址"
            } else {
                textFieldView.redString = ""
            }
        } else if (textFieldView == self.toField) {
            textFieldView.redLabel.isHidden = false
            
            textFieldView.redLabel.isHidden = false
            if (textFieldView.text?.count == 0) {
                textFieldView.redString = "请选择卸货地址"
            } else {
                textFieldView.redString = ""
            }
        } 
        
    }
}
