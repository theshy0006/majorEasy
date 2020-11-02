//
//  NBSearchView.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/29.
//

import UIKit
import RxSwift
import RxCocoa

fileprivate struct SVW_RealNameFailContant {
}

struct SVW_SearchFailParameters {
    
    let titleLabel_width: CGFloat = 200
    let titleLabel_height: CGFloat = 20
    let titleLabel_top: CGFloat = 10
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


@objc class NBSearchView: UIView {

    var title = "搜索"
    var content = ""
    var cancel = ""
    var ok = ""
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
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
        self.centerContainerView.addSubview(phoneField)
        self.centerContainerView.addSubview(searchButton)
        self.centerContainerView.addSubview(confirmButton)
        self.centerContainerView.addSubview(splitline2)
        layoutViews()
    }
    
    //MARK: - 设置约束
    private func layoutViews() {
        let parma = SVW_SearchFailParameters()
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
        phoneField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(15.scaleX)
            make.right.equalToSuperview().offset(-65.scaleX)
            make.height.equalTo(parma.cancelButton_height)
        }
        
        // 确认按钮
        searchButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(50.scaleX)
            make.height.equalTo(parma.cancelButton_height)
            make.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        
        // 确认按钮
        confirmButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(ScreenWidth-70.scaleX)
            make.height.equalTo(parma.cancelButton_height)
            make.right.equalToSuperview()
            make.top.equalTo(phoneField.snp.bottom)
            make.bottom.equalToSuperview()
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
    
    lazy var searchButton: UIButton = {
        let internalConfirmButton = UIButton()
        internalConfirmButton.setTitleColor(color_main_blue, for: .normal)
        internalConfirmButton.setTitle("搜索", for: .normal)
        internalConfirmButton.titleLabel?.font = PingFangRegular(15)
        internalConfirmButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let weakself = self else {return}
            self?.search()
            
        }).disposed(by: disposeBag)
        return internalConfirmButton
    }()
    
    func search(){
        if( phoneField.text?.count != 11 ) {
            NBHUDManager.toast("请输入完整手机号")
            return;
        }
        
        if let search = self.searchAction {
            search()
        }
    }
    
    @objc var okAction:(()->())?
    @objc var searchAction:(()->())?

    
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
    
    lazy var phoneField = NBBottomWarningTextFieldView(placeholderString: "请输入手机号码", textColor: color_normal, font: nil, isSecureTextEntry: nil, redString: "", redFont: nil).then {
        $0.textField.keyboardType = .numberPad
        $0.maxLength = 11
        $0.redLabel.isHidden = false
    }
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

