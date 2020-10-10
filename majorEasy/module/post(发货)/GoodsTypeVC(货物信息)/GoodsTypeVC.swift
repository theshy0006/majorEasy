//
//  GoodsTypeVC.swift
//  yunyou
//
//  Created by wangyang on 2020/4/13.
//  Copyright © 2020 com.boc. All rights reserved.
//

import UIKit

class GoodsTypeVC: BaseVC {

    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var goodsNameBtn: UIButton!
    @IBOutlet weak var otherTextField: UITextField!
    @IBOutlet weak var inputTop: NSLayoutConstraint!

    @IBOutlet weak var minHeightField: UITextField!
    @IBOutlet weak var maxHeightField: UITextField!
    @IBOutlet weak var minVolume: UITextField!
    @IBOutlet weak var maxVolume: UITextField!
    
    @IBOutlet weak var goodsNameField: UITextField!
    let viewModel = GoodsTypeViewModel()

    var myColsure: ((_ name: String, _ packType: String, _ minHeight: String, _ maxHeight: String, _ minVolume: String, _ maxVolume: String) -> ())?

    override func setUpView() {
        self.navigationItem.title = "货物信息"
        self.upView.addSubview(self.typeView)
        self.typeView.top = 82
        
        self.typeView.myColsure = { [weak self] model in
            if model.count != 0 {
                self?.viewModel.packStr = model[0]
            }
        }
        
        self.otherTextField.delegate = self
        self.minHeightField.delegate = self
        self.maxHeightField.delegate = self
        self.minVolume.delegate = self
        self.maxVolume.delegate = self
    }
    
    override func setUpData() {
        //初始化数据
    }

    
    lazy var typeView:NBTypeView = {
        let view = NBTypeView.init(titleArr: viewModel.titleArr, contentArr: viewModel.contentArr, 1, true)
        return view
    }()
    
    
    func resetTypeView(packType: String) {
        let typeArray = packType.components(separatedBy: "、")
        if typeArray.count != 0 {
            typeView.reload(titleArr: typeArray, contentArr: typeArray)
            self.typeView.top = 82
            self.inputTop.constant = self.typeView.height + 5
        }
    }
    
    @IBAction func submit(_ sender: UIButton) {
        guard let goods_name = self.goodsNameField.text else {
            NBHUDManager.toast("请填写货物名称")
            return
        }
        
        if self.viewModel.packStr.count == 0 {
            NBHUDManager.toast("请选择包装方式")
            return
        }
        
        if ((Int(self.minVolume.text ?? "") ?? 0) > 0 && (Int(self.maxVolume.text ?? "") ?? 0) > 0) ||
            ((Int(self.minHeightField.text ?? "") ?? 0) > 0 && (Int(self.maxHeightField.text ?? "") ?? 0) > 0) {
            
            guard let colsure = self.myColsure else {return}
            colsure(goods_name, self.viewModel.packStr, self.minHeightField.text ?? "", self.maxHeightField.text ?? "", self.minVolume.text ?? "", self.maxVolume.text ?? "")
            self.popBack()

        } else {
            NBHUDManager.toast("货重和体积必填一项")
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        
        self.popBack()
    }
    
}

extension GoodsTypeVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == otherTextField &&  textField.text?.count != 0 {
            self.viewModel.packStr = textField.text ?? ""
            self.typeView.resetButtonStatus()
            self.typeView.selectArr.removeAll()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == otherTextField {
            return true
        }
        
        let text = textField.text!
        let len = text.count + string.count - range.length
        return len <= 3

    }
}
