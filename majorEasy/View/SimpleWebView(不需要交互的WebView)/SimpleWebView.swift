//
//  SimpleWebView.swift
//  yunyou
//
//  Created by wangyang on 2020/4/2.
//  Copyright © 2020 com.boc. All rights reserved.
//

class SimpleWebView: BaseWebViewController {
    /// 从别的界面传入的协议数据模型
    var protocolModel: ProtocolModel?
    
    init(protocolModel: ProtocolModel) {
        super.init(nibName: nil, bundle: nil)
        self.protocolModel = protocolModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = protocolModel?.title
        if let urlString = protocolModel?.contentUrl {
            loadlocolHtml(urlString)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        get{
            return .lightContent
        }
    }
}
