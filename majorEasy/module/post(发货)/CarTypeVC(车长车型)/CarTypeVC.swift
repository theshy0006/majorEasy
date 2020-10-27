//
//  CarTypeVC.swift
//  yunyou
//
//  Created by wangyang on 2020/4/14.
//  Copyright © 2020 com.boc. All rights reserved.
//

import UIKit

class CarTypeVC: BaseVC {

    let viewModel = CarTypeViewModel()
    
    var myColsure: ((_ type: String, _ carType: String, _ length: String, _ height: String) -> ())?


    override func setUpView() {
        self.view.addSubview(typeLabel)
        self.view.addSubview(typeView)
        self.view.addSubview(cartypeLabel)
        self.view.addSubview(cartypeView)
        self.view.addSubview(lengthLabel)
        self.view.addSubview(lengthView)
        self.view.addSubview(heightLabel)
        self.view.addSubview(heightView)

        self.typeLabel.frame = CGRect.init(x: 15, y: 66, width: kScreenW, height: 15)
        self.typeView.top = self.typeLabel.bottom

        self.cartypeLabel.frame = CGRect.init(x: 15, y: typeView.bottom+10, width: kScreenW, height: 15)
        self.cartypeView.top = self.cartypeLabel.bottom
        
        self.lengthLabel.frame = CGRect.init(x: 15, y: cartypeView.bottom+10, width: kScreenW, height: 15)
        self.lengthView.top = self.lengthLabel.bottom
        
        self.heightLabel.frame = CGRect.init(x: 15, y: lengthView.bottom+10, width: kScreenW, height: 15)
        self.heightView.top = self.heightLabel.bottom

        
        self.typeView.myColsure = { [weak self] model in
            if model.count != 0 {
                self?.viewModel.type = model[0]
            }
        }
        
        self.cartypeView.myColsure = { [weak self] model in
            if model.count != 0 {
                self?.viewModel.carType = model[0]
            }
        }
        
        self.lengthView.myColsure = { [weak self] model in
            if model.count != 0 {
                self?.viewModel.length = model[0]
            }
        }
        
        self.heightView.myColsure = { [weak self] model in
            if model.count != 0 {
                self?.viewModel.height = model[0]
            }
        }

    }
    
    override func setUpData() {
        //初始化数据
    }

    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.text = "用车类型"
        label.font = PingFangRegular(13)
        return label
    }()
    
    lazy var cartypeLabel: UILabel = {
        let label = UILabel()
        label.text = "车型"
        label.font = PingFangRegular(13)
        return label
    }()
    
    lazy var lengthLabel: UILabel = {
        let label = UILabel()
        label.text = "车长（米）"
        label.font = PingFangRegular(13)
        return label
    }()
    
    lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.text = "车高（选填）"
        label.font = PingFangRegular(13)
        return label
    }()
    
    
    lazy var lengthView:NBTypeView = {
        let view = NBTypeView.init(titleArr: viewModel.lengthArr, contentArr: viewModel.lengthArr, 1, false)
        return view
    }()
    
    lazy var heightView:NBTypeView = {
        let view = NBTypeView.init(titleArr: viewModel.heightArr, contentArr: viewModel.typeArr, 1, false)
        return view
    }()
    
    lazy var typeView:NBTypeView = {
        let view = NBTypeView.init(titleArr: viewModel.typeArr, contentArr: viewModel.typeArr, 1, false)
        return view
    }()
    
    lazy var cartypeView:NBTypeView = {
        let view = NBTypeView.init(titleArr: viewModel.carArr, contentArr: viewModel.typeArr, 1, false)
        return view
    }()

    @IBAction func goBack(_ sender: Any) {
        self.popBack()
    }
    
    @IBAction func okBtnPressed(_ sender: Any) {
        guard let colsure = self.myColsure else {return}
        
        if (self.viewModel.type.count == 0) {
            NBHUDManager.toast("请选择用车类型")
            return
        }
        
        if (self.viewModel.carType.count == 0) {
            NBHUDManager.toast("请选择车型")
            return
        }
        
        if(self.viewModel.length.count == 0) {
            NBHUDManager.toast("请选择车长")
            return
        }
        
        colsure(self.viewModel.type,self.viewModel.carType,self.viewModel.length,self.viewModel.height)
        self.popBack()
    }
    
}
