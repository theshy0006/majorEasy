//
//  BaseWebViewController.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/24.
//

import UIKit
import WebKit

struct SVWBaseWebJavascriptBridgePageConstants {
    static let progressKeyPath = "estimatedProgress"
}

class BaseWebViewController: BaseVC {

    var urlString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutElements()
        self.webView.addObserver(self, forKeyPath: SVWBaseWebJavascriptBridgePageConstants.progressKeyPath, options: .new, context: nil)
    }
    
    func layoutElements() {
        
        webView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        progressView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
    }
    
    //MARK: - 加载网页
    func loadRequest(_ urlString: String) {
        URLCache.shared.removeAllCachedResponses()
        if let url = URL(string: urlString ) {
            self.urlString = urlString
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 15)
            webView.load(request)
        }
    }
    
    func loadlocolHtml(_ urlString: String) {
        URLCache.shared.removeAllCachedResponses()
        if let url = URL(string: urlString ) {
            self.urlString = urlString
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 15)
            webView.load(request)
        }
    }
    
    //MARK: - 网页重新加载
    func reloadWebView() {
        self.loadRequest(self.urlString)
    }
    
    //MARK: - 监听进度条的加载
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //  加载进度条
        if keyPath == SVWBaseWebJavascriptBridgePageConstants.progressKeyPath{
            progressView.alpha = 1.0
            progressView.setProgress(Float(self.webView.estimatedProgress), animated: true)
            if self.webView.estimatedProgress  >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0
                }, completion: { (finish) in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        } else {
            self.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    //MARK: - lazy
    lazy var webView: WKWebView = {
        let web = WKWebView()
        web.navigationDelegate = self
        web.backgroundColor = color_BgColor
        view.addSubview(web)
        return web
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.tintColor = color_main_yellow      // 进度条颜色
        progressView.trackTintColor = UIColor.white // 进度条背景色
        webView.addSubview(progressView)
        return progressView
    }()
    
    deinit {
        self.webView.removeObserver(self, forKeyPath: SVWBaseWebJavascriptBridgePageConstants.progressKeyPath, context: nil)
        self.webView.uiDelegate = nil
        self.webView.navigationDelegate = nil
        NotificationCenter.default.removeObserver(self)
    }

}

extension BaseWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //        webView.
        //        let body = webView.stringByEvaluatingJavaScript(from: "document.body.innerText") ?? "" as String
        
        
    }
}

extension BaseWebViewController {
    func refreshHttpRequest() {
        self.reloadWebView()
    }
}
