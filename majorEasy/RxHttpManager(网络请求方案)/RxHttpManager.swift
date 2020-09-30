//
//  RxHttpManager.swift
//  yunyou
//
//  Created by wangyang on 2020/4/8.
//  Copyright © 2020 com.boc. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON
import RxSwift

class APIError: Error {
    var status:String = ""
    var message:String = ""
}


class RxHttpManager {
    
    /*
     * 获取数据
     * - Parameters:
     * - url: 路由地址
     * - method: 请求方式
     * - parameters: 参数
     * - returnType: 返回类型
     * - Returns: 返回一个Rx序列
     */
    static public func fetchData<T: HandyJSON>(with url: String, method: HTTPMethod = .post, parameters: Parameters?, headers: HTTPHeaders?, returnType: T.Type) -> Observable<T> {
        return Observable<T>.create({ (observer: AnyObserver<T>) -> Disposable in
            self.request(observer: observer, url: url, method: method, parameters: parameters, headers: headers, returnType: returnType)
            return Disposables.create()
        })
    }
    
    /*
     * 网络请求方法
     * - Parameters:
     * - observer: Rx 观察者
     * - url: 路由地址
     * - method: 请求方式
     * - parameters: 参数
     * - returnType: 返回类型
     */
    fileprivate static func request<T: HandyJSON>(observer: AnyObserver<T>, url: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, returnType: T.Type) {
        print("接口地址:\(url)")
        print("接口参数:\(String(describing: parameters))")
        AF.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                self.successHandle(observer: observer, result: response.result, retrunType: returnType)
                break
            case .failure(let error):
                let err = APIError()
                err.status = "\(String(describing: error.responseCode))"
                if (error.localizedDescription.contains(find: "offline")) {
                    err.message = "网络链接失败，请检查网络"
                } else {
                    err.message = error.localizedDescription
                }
                self.failHandle(observer: observer, error: err)
                break
            }
        }
    }
}

/*
 * 请求结果
 */
extension RxHttpManager {
    
    /*
     * 网络请求成功之后的回调
     * - Parameters:
     * - observer: Rx 的观察者(传递数据)
     * - result: 请求结果
     * - retrunType: 返回值类型
     */
    fileprivate static func successHandle<T: HandyJSON>(observer: AnyObserver<T>, result: AFResult<Any>, retrunType: T.Type) {
        // 如果解析出来的不是json
        if case .success(let value) = result {
            guard let jsonDic = value as? [String: Any] else {
                let err = APIError()
                err.status = "10002"
                err.message = "非JSON格式的数据"
                failHandle(observer: observer, error: err)
                return
            }
            // jsonDic是原始数据，将其转成HandyJSON
            guard let responseModel = retrunType.deserialize(from: NSDictionary(dictionary: jsonDic)) else {
                let err = APIError()
                err.status = "10003"
                err.message = "无法解析"
                failHandle(observer: observer, error: err)
                return
            }
            
            // 运友系统返回错误码10000是正确的报文，其他的都是错误的
            if jsonDic["status"] is Int, let code = jsonDic["status"] as? Int {
                if (code == 0) {
                    print("成功报文:\(jsonDic)")
                    observer.onNext(responseModel)
                    observer.onCompleted()
                } else if (code >= 100 && code < 110) {
                    print("token失效:\(jsonDic)")
                    let err = APIError()
                    err.status = String(code)
                    err.message = jsonDic["message"] as? String ?? ""
                    failHandle(observer: observer, error: err)
                    NBHUDManager.toast(err.message)
                    DataCenterManager.default.clear()
                    kAppdelegate.setUpLoginVC()
                } else {
                    print("失败报文:\(jsonDic)")
                    let err = APIError()
                    err.status = String(code)
                    err.message = jsonDic["message"] as? String ?? ""
                    failHandle(observer: observer, error: err)
               }
            }
        }
    }
    
    /*
     * 网络请求失败的回调
     * - Parameters:
     * - observer: Rx 的观察者
     * - error: 错误信息
     */
    fileprivate static func failHandle<T: HandyJSON>(observer: AnyObserver<T>, error: APIError) {
        observer.onError(error)
        observer.onCompleted()
    }
}
