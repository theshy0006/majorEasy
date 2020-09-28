//
//  NBCitySelectView.swift
//  yunyou
//
//  Created by wangyang on 2020/4/15.
//  Copyright © 2020 com.boc. All rights reserved.
//

import UIKit

class NBCitySelectView: UIView {
    
    var dataSource:Array = [NBProvinceModel]()

    var myColsure: ((_ cityName: String, _ cityID: String) -> ())?
    
    
    // 省份
    var provinceArr:Array = [String]()
    // 城市
    var cityArr:Array = [String]()
    // 县城
    var districtArr:Array = [String]()
    
    var provinceStr = ""
    var cityStr = ""
    var districtStr = ""
    var provinceIdStr = ""
    var cityIdStr = ""
    var districtIdStr = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.provinceTableView)
        self.addSubview(self.cityTableView)
        self.addSubview(self.districtTableView)
        layoutViews()
        setupData()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var provinceTableView = UITableView().then {
        $0.backgroundColor = .white
        $0.rowHeight = 40.scaleX
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.delegate = self
        $0.showsVerticalScrollIndicator = false
        $0.register(cellWithClass: UITableViewCell.self)
    }
    
    lazy var cityTableView = UITableView().then {
        $0.backgroundColor = .white
        $0.rowHeight = 40.scaleX
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.delegate = self
        $0.showsVerticalScrollIndicator = false
        $0.register(cellWithClass: UITableViewCell.self)
    }
    
    lazy var districtTableView = UITableView().then {
        $0.backgroundColor = .white
        $0.rowHeight = 40.scaleX
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.delegate = self
        $0.showsVerticalScrollIndicator = false
        $0.register(cellWithClass: UITableViewCell.self)

    }
    
    lazy var titleLabel = UILabel().then {
        $0.backgroundColor = RGBHex(0x676767)
        $0.text = "  可选择服务范围"
        $0.textColor = UIColor.white
        $0.font = PingFangRegular(12)
    }
    
    private func setupData() {
        guard let proviceArray = bg_executeSql("select BG_provinceName,BG_provinceId from ProvinceDB order by BG_provinceId", Province_TableName, NBProvinceModel.self), let array = proviceArray as? [NBProvinceModel] else {return}

        self.dataSource = array
        
        if (!self.provinceArr.contains("全国+")) {
            self.provinceArr.append("全国+")
        }
        
        for model in array {
            let proviceInfo = model.provinceName + "+" + model.provinceId
            if (!self.provinceArr.contains(proviceInfo)) {
                self.provinceArr.append(proviceInfo)
            }
        }
        
        print(self.provinceArr)
        
    }
    
    //MARK: - 设置约束
    private func layoutViews() {

        //
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(28.scaleX)
        }
        
        provinceTableView.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalTo(kScreenW / 3)
        }
        
        cityTableView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(provinceTableView.snp.right)
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalTo(kScreenW / 3)
        }
        
        districtTableView.snp.makeConstraints { (make) -> Void in
            make.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalTo(kScreenW / 3)
        }
    }
    
}

extension NBCitySelectView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == provinceTableView) {
            return self.provinceArr.count
        } else if (tableView == cityTableView) {
            return self.cityArr.count
        } else {
            return self.districtArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: UITableViewCell.self)
        
        if (tableView == provinceTableView) {
            cell.backgroundColor = RGBHex(0xF0F0F0)
            cell.textLabel?.text = self.provinceArr[indexPath.row].components(separatedBy: "+").first ?? ""
        } else if (tableView == cityTableView) {
            cell.backgroundColor = .white
            cell.textLabel?.text = self.cityArr[indexPath.row].components(separatedBy: "+").first ?? ""
        } else {
            cell.backgroundColor = .white
            cell.textLabel?.text = self.districtArr[indexPath.row].components(separatedBy: "+").first ?? ""

        }
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = .white
        cell.textLabel?.textColor = RGBHex(0x333333)
        cell.textLabel?.highlightedTextColor = RGBHex(0xFFA60C)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == provinceTableView) {
            provinceStr = self.provinceArr[indexPath.row].components(separatedBy: "+").first ?? ""
            provinceIdStr = self.provinceArr[indexPath.row].components(separatedBy: "+").last ?? ""
            
            if (provinceIdStr.count != 0) {
                    guard let cityArray = NBCityModel.bg_find(City_TableName, where: "where \(bg_sqlKey("provinceId")) = \(String(self.provinceIdStr)) order by \(bg_sqlKey("cityId"))"), let arr = cityArray as? [NBCityModel] else {return}
                    
                    self.cityArr.removeAll()
                    self.cityArr.append("全境+0")
                    
                    for model in arr {
                        let cityInfo = model.cityName + "+" + model.cityId
                        if (!self.cityArr.contains(cityInfo)) {
                            self.cityArr.append(cityInfo)
                        }
                    }
                    self.cityTableView.reloadData()
                    self.districtArr.removeAll()
                    self.districtTableView.reloadData()
            } else {
                
                guard let colsure = self.myColsure else {return}
                colsure("全国", "")
                
                self.cityArr.removeAll()
                self.districtArr.removeAll()
                self.cityTableView.reloadData()
                self.districtTableView.reloadData()
            }
        } else if (tableView == cityTableView) {
            cityStr = self.cityArr[indexPath.row].components(separatedBy: "+").first ?? ""
            cityIdStr = self.cityArr[indexPath.row].components(separatedBy: "+").last ?? ""
            
            if cityStr.contains("全境") {
                cityStr = self.provinceStr
                cityIdStr = self.provinceIdStr
                
                guard let colsure = self.myColsure else {return}
                colsure(cityStr, cityIdStr)
                
                return
            } else {
                guard let districtArray = NBDistrictModel.bg_find(District_TableName, where: "where \(bg_sqlKey("cityId")) = \(String(self.cityIdStr)) order by \(bg_sqlKey("districtId"))"), let arr = districtArray as? [NBDistrictModel] else {return}
                
                self.districtArr.removeAll()
                self.districtArr.append("全境+0")
                
                for model in arr {
                    let districtInfo = model.districtName + "+" + model.districtId
                    if (!self.districtArr.contains(districtInfo)) {
                        self.districtArr.append(districtInfo)
                    }
                }
                self.districtTableView.reloadData()
            }
        } else {
            districtStr = self.districtArr[indexPath.row].components(separatedBy: "+").first ?? ""
            districtIdStr = self.districtArr[indexPath.row].components(separatedBy: "+").last ?? ""
            
            if districtStr.hasPrefix("全境") {
                if provinceStr.hasPrefix("北京") || provinceStr.hasPrefix("上海") || provinceStr.hasPrefix("天津") || provinceStr.hasPrefix("重庆") || provinceStr.hasPrefix("香港") || provinceStr.hasPrefix("澳门") {
                    cityStr = provinceStr
                    cityIdStr = provinceIdStr
                } else {
                    cityStr = provinceStr + cityStr
                    cityIdStr = provinceIdStr
                }
            } else {
                if provinceStr.hasPrefix("北京") || provinceStr.hasPrefix("上海") || provinceStr.hasPrefix("天津") || provinceStr.hasPrefix("重庆") || provinceStr.hasPrefix("香港") || provinceStr.hasPrefix("澳门") {
                    cityStr = provinceStr + districtStr
                    cityIdStr = provinceIdStr + "+" + provinceIdStr + "+" + districtIdStr
                } else {
                    cityStr = provinceStr + cityStr + districtStr
                    cityIdStr = provinceIdStr + "+" + cityIdStr + "+" + districtIdStr
                }
            }
            
            guard let colsure = self.myColsure else {return}
            colsure(cityStr, cityIdStr)
        }
    }
}
