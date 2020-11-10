//
//  NBUtility.swift
//  yunyou
//
//  Created by wangyang on 2020/4/2.
//  Copyright © 2020 com.boc. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

let CUSTOMER_SERVICE_TEL = "051082030388"

class NBUtility: NSObject {
    //MARK: - 打电话
    public class func showTelephone(_ phone: String = CUSTOMER_SERVICE_TEL) {
        if let telUrl = URL(string: "tel://\(phone)") {
            UIApplication.shared.open(telUrl, options: [:], completionHandler: nil)
        }
    }
    //MARK: - 手机号遮挡显示
    //
    public class func keepoutPhone (phone: String) -> String {
        if phone.count == 11 {
            let returnValue = phone.substr(from: 0, to: 3) + "****" + phone.substr(from: 7, to: 11)
            return returnValue
        }else if phone.count > 11 {
            // 无效的手机号 eg:13498989898_8888
            return phone.substr(to: 10)
        } else {
            return phone
        }
    }
    
    //MARK: - 邮箱遮挡显示
    public class func keepoutEmail (email: String) -> String {
        let beforS = email.components(separatedBy: "@")
        guard let exB = beforS.first else { return email }
        let beforLength = exB.lengthOfBytes(using: String.Encoding.utf8)
        let N = beforLength/3
        let beginString = exB.substr(to: N-1)
        //中间的*
        var tempMiddleString = ""
        for _ in 0 ..< N  {
            tempMiddleString.append("*")
        }
        let endString = exB.substr(from: beforLength + 2 - 2*N)
        let fullString = beginString + tempMiddleString + endString
        guard let exE = beforS.last else { return email }
        return fullString + "@" + exE
    }
    //MARK: - 身份证号遮挡显示
    public class func keepoutIdCard (cardNum: String) -> String {
        if cardNum.count == 18 {
            return cardNum.substr(from: 0, to: 4) + "****" + cardNum.substr(from: 9, to: 17)
        } else {
            return cardNum
        }
    }
    
    //MARK: - 姓名遮挡显示
    public class func keepoutOwerName (name: String) -> String {
        var str = ""
        if name.count != 0 {
            for index in 0 ..< name.count {
                if index == 0 {
                    str += name.substr(to: 1)
                } else if index == 1 {
                    str += "*"
                } else {
                    if index != name.count - 1 {
                        str += "*"
                    } else {
                        str += name.substr(from: name.count - 1)
                    }
                }
            }
            return str
        } else {
            return ""
        }
    }
    
    //MARK: - 常用的正则表达式
    /// 是否为全小写字母
    static func isAllabc(_ string: String) -> Bool {
        
        //        let regex = "^[0-9A-Z\\u4e00-\\u9fa5]{1,20}$"
        let regex = "[a-z]*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: string)
        return isValid
    }
    
    @objc public static func isABCAndNum(_ string: String) -> Bool {
        
        let regex = "[^A-Za-z0-9]"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: string)
        return isValid
    }
    
    /// 是否纯汉字
    static func isAllChinese(_ string: String) -> Bool {
        
        let regex = "[\\u4e00-\\u9fa5]+"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: string)
        return isValid
    }
    
    /// 车牌号规则判断(2019-01-15规则变动.失焦时校验,输入时不限制)
    static func isMatchPlateRule(_ string: String) -> Bool {
        
        let regex = "[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}(([A-Z0-9挂学警港澳]{1})|([0-9A-Z]{2}))"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: string)
        return isValid
    }
    
    /// 检查手机号的合法性
    @objc static func regularPhoneNo(_ phone: String) -> Bool {
        let regex = "^1[123456789]\\d{9}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: phone)
        return isValid
    }
    
    //MARK: - 根据类名加载类
    public class func swiftClassFromString(className: String) -> UIViewController? {
        //方法 NSClassFromString 在Swift中已经不起作用了no effect，需要适当更改
        //官方文档方法：let myPersonClass: AnyClass? = NSClassFromString("MyGreatApp.Person")
        if  let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            let classStringName = "_TtC\(appName.count)\(appName)\(className.count)\(className)"
            let  cls: AnyClass? = NSClassFromString(classStringName)
            assert(cls != nil, "class not found,please check className")
            if let viewClass = cls as? UIViewController.Type {
                let view = viewClass.init()
                return view
            }
        }
        return nil;
    }
    
    
    // MARK: - 是否是模拟器
    public class func isSimulator() -> Bool {
        var isSim = false
        #if arch(i386) || arch(x86_64)
        isSim = true
        #endif
        return isSim
    }
    
    // MARK: - 显示选择相机相册的选择框
    public class func showChooseCameraView(_ viewController: UIViewController, _ realizeView: UIView? ) {
        
        weak var vc = viewController
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle:.actionSheet)
        // 设置2个UIAlertAction
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "从相册选择照片", style: .default, handler: {
            (ac) in
            NBUtility.openCameraAndPhotos(viewController, realizeView, type: .photoLibrary)
        })
        let saveAction = UIAlertAction(title: "拍摄/上传", style: .default, handler: {
            (ac) in
            NBUtility.openCameraAndPhotos(viewController, realizeView, type: .camera)
        })
        
        // 添加到UIAlertController
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        alertController.addAction(deleteAction)
        
        // 弹出
        DispatchQueue.main.async {
            vc?.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - 打开相册相机
    // 如果是view 来获取用户选择的图片就要传 realizeView
    // 如果是viewController 来获取用户选择的图片 只设置viewController就好
    public class func openCameraAndPhotos(_ viewController: UIViewController, _ realizeView: UIView?, type:UIImagePickerController.SourceType ) {
        
        weak var vc = viewController
        
        let pickImageController:UIImagePickerController=UIImagePickerController.init()
        if type == .photoLibrary {
            //获取相册权限
            PHPhotoLibrary.requestAuthorization( { (status) in
                switch status {
                case .notDetermined:
                    print("notDetermined")
                    NBUtility.gotoSetting(viewController,content: "请允许开启相册权限")
                    break
                case .restricted://此应用程序没有被授权访问的照片数据
                    print("restricted")
                    NBUtility.gotoSetting(viewController,content: "请允许开启相册权限")
                    break
                    
                case .denied://用户已经明确否认了这一照片数据的应用程序访问
                    print("denied")
                    NBUtility.gotoSetting(viewController,content: "请允许开启相册权限")
                    break
                case .authorized://已经有权限
                    if let reView = realizeView {
                        DispatchQueue.main.async {
                            pickImageController.delegate = reView as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                            pickImageController.sourceType = UIImagePickerController.SourceType.photoLibrary
                        }
                    } else {
                        DispatchQueue.main.async {
                            pickImageController.delegate = viewController as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                            pickImageController.sourceType = UIImagePickerController.SourceType.photoLibrary
                        }
                    }
                    //pickImageController.allowsEditing = true
                    
                    DispatchQueue.main.async {
                        vc?.present(pickImageController, animated: true, completion: {
                        })
                    }
                    break
                @unknown default:
                    fatalError()
                }
            })
        } else if  type == .camera {
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (ist) in
                let status:AVAuthorizationStatus=AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
                if status == AVAuthorizationStatus.authorized {
                    
                    if let reView = realizeView {
                        pickImageController.delegate = reView as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                    } else {
                        pickImageController.delegate = viewController as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                    }
                    //pickImageController.allowsEditing = true
                    pickImageController.sourceType = UIImagePickerController.SourceType.camera
                    DispatchQueue.main.async {
                        vc?.present(pickImageController, animated: true, completion: {
                        })
                    }
                } else if (status==AVAuthorizationStatus.denied)||(status==AVAuthorizationStatus.restricted) {
                    NBUtility.gotoSetting(viewController,content: "请允许开启相机权限")
                }
            })
        }
    }
    
    //MARK: - 去设置权限
    public class func gotoSetting(_ viewController: UIViewController, content: String ) {
        
        weak var vc = viewController
        
        let alertController:UIAlertController=UIAlertController.init(title: "", message: content, preferredStyle: .alert)
        let sure:UIAlertAction=UIAlertAction.init(title: "去设置", style: .default) { (ac) in
            let url=URL.init(string: UIApplication.openSettingsURLString)
            if UIApplication.shared.canOpenURL(url!) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url!, options: [:], completionHandler: { (ist) in
                        
                    })
                } else {
                    UIApplication.shared.canOpenURL(url!)
                }
            }
        }
        alertController.addAction(sure)
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel))
        DispatchQueue.main.async {
            vc?.present(alertController, animated: true)
        }
    }
}

extension NBUtility {
    //MARK: 类型之间的转换
    /// 字典转换成Data
    public class func jsonToData(jsonDic:Dictionary<String, Any>) -> Data? {
        if (!JSONSerialization.isValidJSONObject(jsonDic)) {
            print("is not a valid json object")
            return nil
        }
        //利用自带的json库转换成Data
        //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
        guard let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: []) else { return nil}
        //Data转换成String打印输出
        let str = String(data:data, encoding: String.Encoding.utf8)
        //输出json字符串
        print("Json Str:\(str!)")
        return data
    }
    
    /// -  JSONString转换为字典
    public class func getDictionaryFromJSONString(jsonString:String) ->NSDictionary? {
        
        guard let jsonData:Data = jsonString.data(using: .utf8) else {return nil}
        guard let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? NSDictionary else {return nil}
        return dict
    }
    
    /// - 这是Data转Dictionary
    func dataToDictionary(data:Data) ->Dictionary<String, Any>? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            guard let dic = json as? Dictionary<String, Any> else {return nil}
            return dic
        } catch _ {
            print("失败")
            return nil
        }
    }
    
    class func localJson(name: String) ->Dictionary<String, Any>? {
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else {return nil}
        let url = URL(fileURLWithPath: path)
        do {
                let data = try Data(contentsOf: url)
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                guard let dic = json as? Dictionary<String, Any> else {return nil}
                return dic
        } catch _ {
             return nil
        }

   }
    
    //  Converted to Swift 5.2 by Swiftify v5.2.30411 - https://swiftify.com/
    class func formatTime(_ string: String) -> String? {

        guard let date = Formatter.iso8601.date(from: string) else {return nil}
        let dateForm = DateFormatter()
        dateForm.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let str = dateForm.string(from: date)
        var timeInterval: TimeInterval = 0
        timeInterval = Date().timeIntervalSince(date)
        if (timeInterval < 0) {
            return (str as NSString?)?.substring(to: 16)
        } else if timeInterval < 60 {
            return String(format: "%.0f秒前", timeInterval)
        } else if timeInterval < 3600 {
            return String(format: "%.0f分钟前", timeInterval / 60)
        } else if timeInterval < 3600 * 24 {
            return String(format: "%.0f小时前", timeInterval / 3600)
        } else {
            return (str as NSString?)?.substring(to: 16)
        }
       
    }
    
    //  Converted to Swift 5.2 by Swiftify v5.2.30411 - https://swiftify.com/
    class func formatUTCTime(_ string: String) -> String? {

        let dateForm = DateFormatter()
        dateForm.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateForm.timeZone = TimeZone.current
        guard let date = dateForm.date(from: string) else {return nil}
        let normalTime = DateFormatter()
        normalTime.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let str = normalTime.string(from: date)
        var timeInterval: TimeInterval = 0
        timeInterval = Date().timeIntervalSince(date)
        if (timeInterval < 0) {
            return (str as NSString?)?.substring(to: 16)
        } else if timeInterval < 60 {
            return String(format: "%.0f秒前", timeInterval)
        } else if timeInterval < 3600 {
            return String(format: "%.0f分钟前", timeInterval / 60)
        } else if timeInterval < 3600 * 24 {
            return String(format: "%.0f小时前", timeInterval / 3600)
        } else if timeInterval < 3600 * 24 * 36 {
            return String(format: "%.0f天前", timeInterval / 3600 / 24)
        }
        else {
            return (str as NSString?)?.substring(to: 16)
        }
       
    }
    
    class func formatLineName(_ string: String) -> String {
        if( string.contains("上海上海") ) {
            return string.replacingOccurrences(of: "上海上海", with: "上海")
        } else if( string.contains("北京北京") ) {
            return string.replacingOccurrences(of: "北京北京", with: "北京")
        } else if( string.contains("天津天津") ) {
            return string.replacingOccurrences(of: "天津天津", with: "天津")
        } else if( string.contains("重庆重庆") ) {
            return string.replacingOccurrences(of: "重庆重庆", with: "重庆")
        } else {
            return string
        }
    }

    
    class func formatAddress(_ address: String) -> [String:String]{
        var dic = [String : String]()
        let fromArray = address.components(separatedBy: ",")
        if fromArray.count == 2 {
            let fromArr = fromArray[1].components(separatedBy: "+")
            var cityName = ""
            if fromArr.count == 3 {
                dic["ProvinceId"] = fromArr[0]
                dic["ProvinceName"] = NBTookit.findProvinceName(fromArr[0])
                dic["CityId"] = fromArr[1]
                if NBTookit.findCityName(fromArr[1]) == nil {
                    cityName = NBTookit.findProvinceName(fromArr[0])
                } else {
                    cityName = NBTookit.findCityName(fromArr[1])
                }
                dic["CityName"] = cityName
                dic["DistrictId"] = fromArr[2]
                dic["DistrictName"] = NBTookit.findDistrictName(fromArr[2])
            } else if fromArr.count == 2 {
                dic["ProvinceId"] = fromArr[0]
                dic["ProvinceName"] = NBTookit.findProvinceName(fromArr[0])
                dic["CityId"] = fromArr[1]
                dic["CityName"] = NBTookit.findCityName(fromArr[1])
            } else if fromArr.count == 1 {
                dic["ProvinceId"] = fromArr[0]
                dic["ProvinceName"] = NBTookit.findProvinceName(fromArr[0])
                dic["CityId"] = ""
                dic["CityName"] = ""
            }
        } else if fromArray.count == 1 {
            dic["ProvinceId"] = ""
            dic["ProvinceName"] = ""
            dic["CityId"] = ""
            dic["CityName"] = ""
        }
        return dic
        
    }
    
}

