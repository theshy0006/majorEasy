//
//  HttpManager.swift
//  Sunping
//
//  Created by dede wang on 2019/11/20.
//  Copyright © 2019 com.zxc. All rights reserved.
//

import UIKit
import Alamofire

let httpManager = HttpManager()

typealias SuccessCallBack = ((_ result:[String: Any])->())?
typealias FailureCallBack = ((_  error:[String: Any])->())?

// 构建公共报文头
public func ConstructHeaders(_ header: Dictionary<String, String>?)-> HTTPHeaders {
    
    var headers: HTTPHeaders = [
        "djwyToken": DataCenterManager.default.userInfo.token ?? "",
        "Content-Type":"application/x-www-form-urlencoded;charset=UTF-8;"  
    ]
    guard let tempHeader = header else{return headers}
    for (key, value) in tempHeader {
        headers.add(name: key, value: value)
    }

    print("报文头名称:[\(headers)]")
    return headers
}

// 构建公共报文头
public func ConstructUploadHeaders(_ header: Dictionary<String, String>?)-> HTTPHeaders {
    
    var headers: HTTPHeaders = [
        "djwyToken": DataCenterManager.default.userInfo.token ?? "",
        "Content-Type":"multipart/form-data; charset=utf-8",
    ]
    guard let tempHeader = header else{
        return headers
    }
    for (key, value) in tempHeader {
        headers.add(name: key, value: value)
    }

    print("报文头名称:[\(headers)]")
    return headers
}


// 构建公共错误信息
public func ConstructErrorMessage(_ error: NSError) -> [String: Any]{
    if( error.code == -1 ) {
        return error.userInfo
    } else {
        var dic = [String: String]()
        dic["errorCode"] = "\(error.code)"
        if (error.localizedDescription.contains(find: "offline")) {
            dic["errorMessage"] = "网络链接失败，请检查网络"
        } else {
            dic["errorMessage"] = error.localizedDescription
        }
        
        return dic
    }
}


class HttpManager: NSObject {
    
    public static var shared : HttpManager {
        return httpManager
    }
    
    let sharedSessionManager: Session = {
        let configuration = URLSessionConfiguration.default
        // 设置超时时间为10秒
        configuration.timeoutIntervalForRequest = 15
        return Session.init(configuration: configuration, delegate: SessionDelegate.init(), serverTrustManager: nil)
        
    }()
    
    // Post 请求
    func post(url: String,
                     header: Dictionary<String, String>?,
                     parametersBody: Dictionary<String, Any>?,
                     success: SuccessCallBack = nil,
                     failure: FailureCallBack = nil) {
        print("接口地址:\(url)")
        print("报文头名称:[\(ConstructHeaders(nil))]")
        print("接口参数:\(String(describing: parametersBody))")
        AF.request(url, method: .post, parameters: parametersBody, encoding: JSONEncoding.default, headers: nil, interceptor: nil).validate(statusCode: 200..<300).validate(contentType: ["application/json", "text/json", "text/plain"])
            .responseJSON { (response) in
                switch response.result {
                case .success(let json):
                    if let dict = json as? [String:Any] {
                        if dict["code"] is Int, let code = dict["code"] as? Int {
                            if (code == 10000) {
                                debugPrint("成功报文:\(dict)")
                                if let successCallBack = success {
                                    successCallBack(dict)
                                }
                            } else {
                                debugPrint("失败报文:\(dict)")
                                var dic = [String: String]()
                                dic["errorCode"] = dict["code"] as? String
                                dic["errorMessage"] = dict["message"] as? String
                                failure?(dic)
                            }
                        }
                    }
                case .failure(let error):
                    print("---***请求错误***\n错误描述:\((error as NSError).description)")
                    failure?(ConstructErrorMessage(error as NSError))
                }
        }
    }
    
    // Get 请求
    func get(url: String,
                     header: Dictionary<String, String>?,
                     parametersUrl: Dictionary<String, Any>?,
                     success: SuccessCallBack = nil,
                     failure: FailureCallBack = nil) {
        print("接口地址:\(url)")
        print("报文头名称:[\(ConstructHeaders(nil))]")
        print("接口参数:\(String(describing: parametersUrl))")

        
        AF.request(url, method: .get, parameters: parametersUrl, encoding: URLEncoding.default, headers: ConstructHeaders(nil)).validate(statusCode: 200..<300).validate(contentType: ["application/json", "text/json", "text/plain"])
            .responseJSON { (response) in
                switch response.result {
                case .success(let json):
                    if let dict = json as? [String:Any] {
                        if dict["code"] is Int, let code = dict["code"] as? Int {
                            if (code == 10000) {
                                debugPrint("成功报文:\(dict)")
                                if let successCallBack = success {
                                    successCallBack(dict)
                                }
                            } else {
                                debugPrint("失败报文:\(dict)")
                                var dic = [String: String]()
                                dic["errorCode"] = dict["code"] as? String
                                dic["errorMessage"] = dict["message"] as? String
                                failure?(dic)
                            }
                        }
                    }
                case .failure(let error):
                    print("---***请求错误***\n错误描述:\((error as NSError).description)")
                    failure?(ConstructErrorMessage(error as NSError))
                }
            }
    }

}



