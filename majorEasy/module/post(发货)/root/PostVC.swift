//
//  PostVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/24.
//

import UIKit

class PostVC: BaseVC {

    let viewModel = PostViewModel()
    
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
    @IBOutlet weak var typeButton: UIButton!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var asignButton: UIButton!
    
    
    
    var deliveryDataApp = ""
    var arrivalDataApp = ""

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
        $0.textField.keyboardType = .decimalPad
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
        self.viewModel.mySuppliesInfo.loadMode = 1
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
        
        self.agreeButton.isSelected = true;
        self.offenButton.isSelected = true;
        
        self.agreeButton.setImage(ImageNamed("uncheck"), for: .normal)
        self.agreeButton.setImage(ImageNamed("check"), for: .selected)
        
        self.offenButton.setImage(ImageNamed("uncheck"), for: .normal)
        self.offenButton.setImage(ImageNamed("check"), for: .selected)
        
        asignButton.layer.borderWidth = 1
        asignButton.layer.borderColor = tabbarFontSelectColor.cgColor
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
        offenButton.isSelected = !offenButton.isSelected
    }
    
    @IBAction func agreeButtonPressed(_ sender: UIButton) {
        agreeButton.isSelected = !agreeButton.isSelected
    }
    
    @IBAction func fromButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        self.chooseAreaView.show()
        chooseAreaView.myColsure = { [weak self] (cityName, cityId) in
            print(cityName)
            print(cityId)
            self?.fromCity = cityName
            self?.fromCityId = cityId
            self?.fromField.text = cityName

            self?.viewModel.mySuppliesInfo.loadPlace = cityName
            self?.viewModel.mySuppliesInfo.loadPlaceCode = cityId.substr(from: cityId.count-6, to: nil)
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
            
            self?.viewModel.mySuppliesInfo.unloadPlace = cityName
            self?.viewModel.mySuppliesInfo.unloadPlaceCode = cityId.substr(from: cityId.count-6, to: nil)
        }
    }
    
    @IBAction func goodsButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        let vc = GoodsTypeVC()
        vc.myColsure = { [weak self] (name, packType, minHeight, maxHeight, minVolume, maxVolume) in
            var title = ""
            if (minHeight.count == 0 && maxHeight.count == 0) {
                title = name + "/" + packType + "/"  + minVolume + "-" + maxVolume
                    + "方"
            } else if (minVolume.count == 0 && maxVolume.count == 0){
                title = name + "/" + packType + "/"  + minHeight + "-" + maxHeight + "吨"
            } else {
                title = name + "/" + packType + "/" + minHeight + "-" + maxHeight + "吨" + "/"  + minVolume + "-" + maxVolume
                + "方"
            }
            
            self?.viewModel.mySuppliesInfo.goodsWeight_lower = Float(minHeight) ?? 0.0
            self?.viewModel.mySuppliesInfo.goodsWeight_upper = Float(maxHeight) ?? 0.0
            self?.viewModel.mySuppliesInfo.goodsVolume_lower = Float(minVolume) ?? 0.0
            self?.viewModel.mySuppliesInfo.goodsVolume_upper = Float(maxVolume) ?? 0.0
            self?.viewModel.mySuppliesInfo.goodsName = name
            self?.viewModel.mySuppliesInfo.packType = packType
            
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
            
            self?.viewModel.mySuppliesInfo.useMode = type
            //self?.viewModel.mySuppliesInfo.goodsVolume_upper = cartype
            self?.viewModel.mySuppliesInfo.vehicleLength = length
            self?.viewModel.mySuppliesInfo.vehicleHeight = height
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func specificationButtonPressed(_ sender: UIButton) {
        let vc = GoodStandardVC()
        vc.myColsure = { [weak self] (length, width, height, diameter, remark) in
            var title = ""
            title = "长\(length)宽\(width)高\(height)直径\(diameter)"
            
            self?.viewModel.mySuppliesInfo.goodsLength = Float(length) ?? 0.0
            self?.viewModel.mySuppliesInfo.goodsWide = Float(width) ?? 0.0
            self?.viewModel.mySuppliesInfo.goodsHeight = Float(height) ?? 0.0
            self?.viewModel.mySuppliesInfo.goodsDiameter = Float(diameter) ?? 0.0
            
            
            self?.specificationField.text = title
        }
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func typeButtonPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle:.actionSheet)

        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let oneAction = UIAlertAction(title: "一装一卸", style: .default, handler: { [weak self]
            (ac) in
            self?.typeField.text = "一装一卸"
            self?.viewModel.mySuppliesInfo.loadMode = 1
            
            
        })
        let twoAction = UIAlertAction(title: "一装两卸", style: .default, handler: { [weak self]
            (ac) in
            self?.typeField.text = "一装两卸"
            self?.viewModel.mySuppliesInfo.loadMode = 2
        })
        
        let threeAction = UIAlertAction(title: "一装多卸", style: .default, handler: { [weak self]
            (ac) in
            self?.typeField.text = "一装多卸"
            self?.viewModel.mySuppliesInfo.loadMode = 3
        })
        
        let fourAction = UIAlertAction(title: "两装一卸", style: .default, handler: { [weak self]
            (ac) in
            self?.typeField.text = "两装一卸"
            self?.viewModel.mySuppliesInfo.loadMode = 4
        })
        
        let fiveAction = UIAlertAction(title: "两装两卸", style: .default, handler: { [weak self]
            (ac) in
            self?.typeField.text = "两装两卸"
            self?.viewModel.mySuppliesInfo.loadMode = 5
        })
        
        let sixAction = UIAlertAction(title: "多装多卸", style: .default, handler: { [weak self]
            (ac) in
            self?.typeField.text = "多装多卸"
            self?.viewModel.mySuppliesInfo.loadMode = 6
        })
        
        // 添加到UIAlertController
        alertController.addAction(cancelAction)
        alertController.addAction(oneAction)
        alertController.addAction(twoAction)
        alertController.addAction(threeAction)
        alertController.addAction(fourAction)
        alertController.addAction(fiveAction)
        alertController.addAction(sixAction)
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func timeButtonPressed(_ sender: UIButton) {
        
        let dataArray = OCUtility.getDatesWithStartDate()
        
        CGXPickerView.showStringPicker(withTitle: "时间", dataSource: [dataArray,["全天","凌晨(0:00-6:00)","上午(06:00-12:00)","下午(12:00-18:00)","晚上(18:00-24:00)"]], defaultSelValue: nil, isAutoSelect: false, manager: nil, resultBlock: { [weak self] selectValue, selectRow in
            guard let array = selectValue as? Array<String> else {return}
            self?.timeField.text = array[0] + " " + array[1]
            
            self?.deliveryDataApp = array[0]
            self?.arrivalDataApp = array[0]
            self?.viewModel.mySuppliesInfo.deliveryTime = array[1]
        })
    }
}

extension PostVC: NBBottomWarningTextFieldDelegate {
    func NBBottomWarningTextFieldDidEndEditing(text: String?, textFieldView: NBBottomWarningTextFieldView) {
    }
    
    @IBAction func asignBtnPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func sendBtnPressed(_ sender: UIButton) {
        
        if (fromField.text?.count == 0 || toField.text?.count == 0) {
            NBHUDManager.toast("请选择城市/区域")
            return
        }
        
        if (goodsField.text?.count == 0) {
            NBHUDManager.toast("请输入货物信息")
            return
        }
        
        if (lengthField.text?.count == 0) {
            NBHUDManager.toast("请输入车型车长")
            return
        }
        
        if (timeField.text?.count == 0) {
            NBHUDManager.toast("请选择装货时间")
            return
        }
        
        self.viewModel.mySuppliesInfo.loadPlaceDetail = fromAddressField.text
        self.viewModel.mySuppliesInfo.unloadPlaceDetail = toAddressField.text
        
        NBLoadManager.showLoading()
        viewModel.send(deliveryDataApp:deliveryDataApp, arrivalDataApp:arrivalDataApp, success: { model in
           NBLoadManager.hidLoading()
           kAppdelegate.setUpTabBar()
           NBHUDManager.toast(model.message ?? "")
        }) { (error) in
           NBLoadManager.hidLoading()
           NBHUDManager.toast(error.message)
        }
        
    }
    
}
