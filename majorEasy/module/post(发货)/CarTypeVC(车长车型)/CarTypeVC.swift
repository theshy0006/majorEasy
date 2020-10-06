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
    
    var myColsure: ((_ length1: String, _ length2: String, _ length3: String, _ type1: String, _ type2: String, _ type3: String) -> ())?


    override func setUpView() {
        self.view.addSubview(self.lengthView)
        self.lengthView.top = 83
        self.view.addSubview(self.typeView)
        self.typeView.top = 365
        
        self.lengthView.myColsure = { [weak self] model in
            for (index, length) in model.enumerated() {
                self?.viewModel.selectLength[index] = length
            }
        }
        
        self.typeView.myColsure = { [weak self] model in
            for (index, type) in model.enumerated() {
                self?.viewModel.selectType[index] = type
            }
        }
    }
    
    override func setUpData() {
        //初始化数据
    }


    lazy var lengthView:NBTypeView = {
        let view = NBTypeView.init(titleArr: viewModel.lengthArr, contentArr: viewModel.lengthArr, 3, false)
        return view
    }()
    
    lazy var typeView:NBTypeView = {
        let view = NBTypeView.init(titleArr: viewModel.typeArr, contentArr: viewModel.typeArr, 3, false)
        return view
    }()

    @IBAction func goBack(_ sender: Any) {
        self.popBack()
    }
    
    @IBAction func okBtnPressed(_ sender: Any) {
        guard let colsure = self.myColsure else {return}
        
        if(self.viewModel.selectLength[0].count == 0 &&
            self.viewModel.selectLength[1].count == 0 &&
            self.viewModel.selectLength[2].count == 0) {
            NBHUDManager.toast("请选择车长")
            return
        }
        
        if (self.viewModel.selectType[0].count == 0 &&
        self.viewModel.selectType[1].count == 0 &&
        self.viewModel.selectType[2].count == 0) {
            NBHUDManager.toast("请选择车型")
            return
        }
        
        
        colsure(self.viewModel.selectLength[0],self.viewModel.selectLength[1],self.viewModel.selectLength[2],self.viewModel.selectType[0],self.viewModel.selectType[1],self.viewModel.selectType[2])
        self.popBack()
    }
    
}
