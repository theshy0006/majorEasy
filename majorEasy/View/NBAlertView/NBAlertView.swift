//
//  NBAlertView.swift
//  TanCheng
//
//  Created by wangyang on 2019/12/3.
//  Copyright © 2019 bocweb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

fileprivate struct SVW_RealNameFailContant {
}

struct SVW_RealNameFailParameters {
    
    let titleLabel_width: CGFloat = 200
    let titleLabel_height: CGFloat = 20
    let titleLabel_top: CGFloat = 19
    let titleLabel_left: CGFloat = 45.scaleX
    let titleLabel_right: CGFloat = -45.scaleX
    
    let contentLabel_height: CGFloat = 50
    
    let alertLabel_top: CGFloat = 5
    let alertLabel_width: CGFloat = 163
    let alertLabel_height: CGFloat = 20
    
    let cancelButton_height: CGFloat = 40
    
    let splitline_left: CGFloat = 15
    let splitline_right: CGFloat = -15
    let splitline_height: CGFloat = 0.5
    
    let splitline3_width: CGFloat = 0.5
    let splitline3_height: CGFloat = 40
    
    let splitline1_bottom: CGFloat = -36
    let splitline0_bottom: CGFloat = -44
    
    let tipsButton_width: CGFloat = 110
    let tipsButton_height: CGFloat = 36
    
    let sendButton_width: CGFloat = 86
    let sendButton_height: CGFloat = 44
    
    let codeLabel_bottom: CGFloat = -12
    let codeLabel_width: CGFloat = 45
    let codeLabel_height: CGFloat = 20
    
    let phoneContentLabel_width: CGFloat = 100
    let phoneContentLabel_height: CGFloat = 20
    let phoneContentLabe_left: CGFloat = 10
    
    let codeContentField_width: CGFloat = 116
    let codeContentField_height: CGFloat = 45
    let codeContentField_bottom: CGFloat = 0
    let codeContentField_left: CGFloat = 10
}


@objc class NBAlertView: UIView {

    var title = ""
    var content = ""
    var cancel = ""
    var ok = ""
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
    }
    
    @objc convenience init(title: String, content: String, cancel: String, ok: String) {
        self.init(frame: CGRect.zero)
        self.title = title
        self.content = content
        self.cancel = cancel
        self.ok = ok
        
        
        initData()
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.addSubview(centerContainerView)
        self.centerContainerView.addSubview(titleLabel)
        self.centerContainerView.addSubview(contentLabel)
        self.centerContainerView.addSubview(confirmButton)
        self.centerContainerView.addSubview(cancelButton)
        self.centerContainerView.addSubview(splitline3)
        self.centerContainerView.addSubview(splitline2)
        layoutViews()
    }
    
    //MARK: - 设置约束
    private func layoutViews() {
        let parma = SVW_RealNameFailParameters()
        // 中间视图
        centerContainerView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(parma.titleLabel_left)
            make.right.equalTo(parma.titleLabel_right)
            make.center.equalToSuperview()
        }
        
        // 身份验证
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(parma.titleLabel_top)
            make.width.equalTo(parma.titleLabel_width)
            make.height.equalTo(parma.titleLabel_height)
            make.centerX.equalToSuperview()
        }
        
        // 文本内容
        contentLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(15.scaleX)
            make.right.equalToSuperview().offset(-15.scaleX)
        }
        
        // 确认按钮
        confirmButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo((ScreenWidth-70.scaleX) / 2)
            make.height.equalTo(parma.cancelButton_height)
            make.right.equalToSuperview()
            make.top.equalTo(contentLabel.snp.bottom).offset(15)
            make.bottom.equalToSuperview()
        }
        // 取消按钮
        cancelButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo((ScreenWidth-70.scaleX) / 2)
            make.height.equalTo(parma.cancelButton_height)
            make.left.equalToSuperview()
            make.top.equalTo(contentLabel.snp.bottom).offset(15)
        }
        // splitline3
        splitline3.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(parma.splitline3_width)
            make.height.equalTo(parma.splitline3_height)
            make.centerX.equalToSuperview()
            make.top.equalTo(cancelButton.snp.top)
        }
        // splitline2
        splitline2.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(parma.splitline_height)
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(cancelButton.snp.top).offset(0)
        }
    }
    
    func initData() {

    }
    
    lazy var centerContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        return containerView
    }()
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = color_title
        label.font = PingFangRegular(16)
        label.textAlignment = .center
        label.text = self.title
        return label
    }()
    
    lazy var confirmButton: UIButton = {
        let internalConfirmButton = UIButton()
        internalConfirmButton.setTitleColor(color_main_blue, for: .normal)
        internalConfirmButton.setTitle(self.ok, for: .normal)
        internalConfirmButton.titleLabel?.font = PingFangRegular(15)
        internalConfirmButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let weakself = self else {return}
            weakself.hide()
            if let ok = weakself.okAction {
                ok()
            }
        }).disposed(by: disposeBag)
        return internalConfirmButton
    }()
    
    lazy var cancelButton: UIButton = {
        let internalCancelButton = UIButton()
        internalCancelButton.backgroundColor = UIColor.white
        internalCancelButton.setTitleColor(color_main_blue, for: .normal)
        internalCancelButton.setTitle(self.cancel, for: .normal)
        internalCancelButton.titleLabel?.font = PingFangRegular(15)
        internalCancelButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let weakself = self else {return}
            weakself.hide()
            if let cancel = weakself.cancelAction {
                cancel()
            }
        }).disposed(by: disposeBag)
        return internalCancelButton
    }()
    
    @objc var okAction:(()->())?
    @objc var cancelAction:(()->())?

    @objc lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byCharWrapping
        label.text = self.content
        label.font = PingFangRegular(13)
        label.textColor = RGBHex(0x333333)
        return label
    }()
    
    lazy var splitline3: UIView = {
        let view = UIView()
        view.backgroundColor = RGBHex(0xf0f0f0)
        return view
    }()
    
    lazy var splitline2: UIView = {
        let view = UIView()
        view.backgroundColor = RGBHex(0xf0f0f0)
        return view
    }()
    
    lazy var splitline1: UIView = {
        let view = UIView()
        view.backgroundColor = RGBHex(0xf0f0f0)
        return view
    }()

    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    @objc func show(vc: UIViewController) {
        vc.view.addSubview(self)
    }
    
    @objc func show(superView: UIView) {
        superView.addSubview(self)
    }
    
    func hide() {
        self.removeFromSuperview()
    }
    
}

