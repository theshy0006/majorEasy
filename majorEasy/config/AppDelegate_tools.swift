//
//  AppDelegate_tools.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/24.
//

import UIKit
import IQKeyboardManagerSwift
 
// MARK: - 启动第三方库
extension AppDelegate {
    func launchPartner(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        // 注册微信服务
        //向微信注冊
        
        // 注册键盘
        setupIQKeyboardManager()
        // 启动百度地图
        setUpBaiduMap()
        // 加载本地城市数据库
        setUpCityDB()
        // 加载微信分享
        setUpWX()
        
    }
    
    func setupIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "完成"
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
    }
    
    func setUpBaiduMap() {
        BaiduMapManager.shared().setUpData()
    }
    
    func setUpWX() {
        WXApi.registerApp(WX_APP_ID)
    }
    
    func setUpCityDB() {
        /** 城市数据库 */
        bg_setDebug(true);
        bg_setSqliteName("yunyou");
        
        if let _:String = NBCacheManager.getShared().get(key: "db", type: .userDefault) {
        } else {
            if let dic = NBUtility.localJson(name: "city") {
                NBAreaModel.bg_clear(Province_TableName)
                NBAreaModel.bg_clear(City_TableName)
                NBAreaModel.bg_clear(District_TableName)
                
                //异步写入DB
                DispatchQueue.global(qos: .background).async { [weak self] in
                    self?.createCityDB(dic)
                }
            }
        }
    }
    func createCityDB(_ responseObject: [String:Any]) {
        if responseObject["provinces"] is [[String:Any]], let provinceArray = responseObject["provinces"] as? [[String:Any]] {
            
            for provinceDic in provinceArray {
                // 创建省份数据库表
                let pModel = NBProvinceModel()
                pModel.bg_tableName = Province_TableName
                pModel.provinceId = String(provinceDic["id"] as? Int ?? 0)
                let proviceName = provinceDic["name"] as? String ?? ""
                
                if proviceName.hasSuffix("省") {
                    pModel.provinceName = proviceName.substr(to: proviceName.count-1)
                } else if proviceName.hasSuffix("市") {
                    pModel.provinceName = proviceName.substr(to: proviceName.count-1)
                } else if proviceName.hasSuffix("自治区") {
                    
                    if proviceName.hasPrefix("内蒙古") {
                        pModel.provinceName = proviceName.substr(to: 3)
                    } else {
                        pModel.provinceName = proviceName.substr(to: 2)
                    }
                } else if proviceName.hasSuffix("特别行政区") {
                    pModel.provinceName = proviceName.substr(to: 2)
                }
                pModel.bg_save()
                
                // 创建城市数据库表
                if provinceDic["cities"] is [[String:Any]], let cityArray = provinceDic["cities"] as? [[String:Any]] {
                    for cityDict in cityArray {
                        let cModel = NBCityModel()
                        cModel.bg_tableName = City_TableName
                        cModel.provinceId =  String(provinceDic["id"] as? Int ?? 0)
                        cModel.cityId = String(cityDict["id"] as? Int ?? 0)
                        cModel.cityName = cityDict["name"] as? String ?? ""
                        cModel.cityInitial = cityDict["initial"] as? String ?? ""
                        cModel.cityPinYin = cityDict["pinyin"] as? String ?? ""
                        cModel.bg_save()
                        
                        // 创建区数据库表
                        if (pModel.provinceName == "香港") || (pModel.provinceName == "澳门") {
                        } else {
                            // 创建城市数据库表
                            if cityDict["districts"] is [[String:Any]], let districtArray = cityDict["districts"] as? [[String:Any]] {
                                
                                for districtDic in districtArray {
                                    let dModel = NBDistrictModel()
                                    dModel.bg_tableName = District_TableName
                                    dModel.cityId = String(cityDict["id"] as? Int ?? 0)
                                    dModel.districtId = String(districtDic["id"] as? Int ?? 0)
                                    dModel.districtName = districtDic["name"] as? String ?? ""
                                    dModel.bg_save()
                                }
                            }
                        }
                    }
                }
            }
        }
        let result = NBCacheManager.getShared().set(key: "db", type: .userDefault, data: "1")
        print("数据库创建" + (result == .success ? "成功":"失败"))
    }
}
