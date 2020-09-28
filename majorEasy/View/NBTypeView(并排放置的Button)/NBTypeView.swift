//
//  NBTypeView.swift
//  yunyou
//
//  Created by wangyang on 2020/4/13.
//  Copyright © 2020 com.boc. All rights reserved.
//

import UIKit

class NBTypeView: UIView {

    var titleArr:Array = [String]()
    var selectArr:Array = [String]()
    var contentArr:Array = [String]()
    var maxCount = 1
    var radioType = true
    
    var myColsure: ((_ model: [String]) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(titleArr: [String], contentArr: [String], _ maxCount: Int = 1, _ radioType: Bool = true) {
        let row = titleArr.count % 4
        let col = titleArr.count / 4
        var height = 0
        if row == 0 {
            height = 40 * col
        } else {
            height = 40 * (col+1)
        }
        self.init(frame:CGRect(x: 0, y: 0, width: Int(ScreenWidth), height: height))
        
        self.titleArr = titleArr
        self.contentArr = contentArr
        self.maxCount = maxCount
        self.radioType = radioType
        
        
        initData()
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initData() {
        
    }
    
    func createUI() {
        self.backgroundColor = UIColor.white
        let btnWidth: Int = Int((ScreenWidth - 60) / 4)
        
        for i in 0..<self.titleArr.count {
            let row = i % 4
            let col = i / 4
            
            let menuBtn = UIButton(type: .custom)
            menuBtn.setTitle(self.titleArr[i], for: .normal)
            menuBtn.setTitleColor(RGBHex(0x666666), for: .normal)
            menuBtn.setTitleColor(UIColor.white, for: .selected)
            menuBtn.titleLabel?.font = PingFangRegular(14)
            menuBtn.tag = i
            menuBtn.layer.cornerRadius = 4
            menuBtn.layer.borderColor = RGBHex(0xDDDDDD).cgColor
            menuBtn.layer.borderWidth = 1
            menuBtn.layer.masksToBounds = true
            menuBtn.backgroundColor = .white
            self.addSubview(menuBtn)
            
            menuBtn.snp.makeConstraints { (make) -> Void in
                make.top.equalToSuperview().offset(10 + 40 * col)
                make.left.equalTo((btnWidth + 10) * row + 15)
                make.width.equalTo(btnWidth)
                make.height.equalTo(30);
            }
            menuBtn.addTarget(self, action: #selector(menuBtnClick(_:)), for: .touchUpInside)
        }
    }
    
    @objc func menuBtnClick(_ button: UIButton) {

        button.isSelected = !button.isSelected
        if (button.isSelected) {
            if(self.selectArr.count >= maxCount && self.radioType == false) {
                button.isSelected = false
                return
            }
            if (radioType) {
                resetButtonStatus()
                button.isSelected = true
            }
            button.backgroundColor = color_main_yellow;
            button.layer.borderColor = color_main_yellow.cgColor
            self.selectArr.append(button.titleLabel?.text ?? "")
        } else {
                button.backgroundColor = .white
                button.layer.borderColor = RGBHex(0xDDDDDD).cgColor
                guard let isIndexOf = self.selectArr.firstIndex(of: button.titleLabel?.text ?? "") else {return}
                self.selectArr.remove(at: isIndexOf)
        }
        guard let colsure = self.myColsure else {return}
        colsure(self.selectArr)
    }
    
    func resetButtonStatus() {
        for view in self.subviews {
            if let v = view as? UIButton {
                v.isSelected = false
                v.backgroundColor = .white;
                v.layer.borderColor = color_BgColor.cgColor
            }
        }
    }
    
    
    
    func reload(titleArr: [String], contentArr: [String]) {
        self.titleArr.removeAll()
        self.contentArr.removeAll()
        
        for title in titleArr {
            self.titleArr.append(title)
        }
        
        for content in contentArr {
            self.contentArr.append(content)
        }
        self.removeAllSubviews()
       
        let row = titleArr.count % 4
        let col = titleArr.count / 4
        var height = 0
        if row == 0 {
            height = 40 * col
        } else {
            height = 40 * (col+1)
        }
        self.frame = CGRect(x: 0, y: 0, width: Int(ScreenWidth), height: height)
        
        
        createUI()
    }

}
