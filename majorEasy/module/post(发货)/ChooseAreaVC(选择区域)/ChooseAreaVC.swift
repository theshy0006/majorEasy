//
//  ChooseAreaVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/2.
//

import UIKit

class ChooseAreaVC: BaseVC {

    var itemTitle = ""
    
    var myColsure: ((_ cityName: String, _ cityID: String) -> ())?
    
    convenience init(itemTitle: String) {
        self.init()
        self.itemTitle = itemTitle
    }

    override func setUpView() {
        self.navigationItem.title = itemTitle
        self.view.addSubview(self.chooseAreaView)
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        chooseAreaView.myColsure = { [weak self] (cityName, cityId) in
            print(cityName)
            print(cityId)
            self?.selectFinish(cityName, cityId)
            
            
        }
    }
    
    lazy var chooseAreaView = NBCitySelectView(frame: CGRect(x: 0, y: kScreenH/4, width: kScreenW, height: 3*kScreenH/4 - SafeAreaBottomHeight - TabBarHeight)).then {
        $0.backgroundColor = .white
    }
    
    func selectFinish(_ cityName: String, _ cityId: String ) {
        guard let colsure = self.myColsure else {return}
        colsure(cityName, cityId)
        self.popBack()
    }
}
