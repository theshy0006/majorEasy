//
//  NBBottomWarningTextFieldView.swift
//  Notebook
//
//  Created by dede wang on 2019/9/20.
//  Copyright © 2019 com.boc. All rights reserved.
//

import UIKit
import SnapKit

fileprivate struct NBTextFieldBottomLabelContant {
    static let placehold = ""
}

@objc protocol NBBottomWarningTextFieldDelegate: class {
    @objc func NBBottomWarningTextFieldDidEndEditing(text: String?, textFieldView: NBBottomWarningTextFieldView)
    
    @objc optional func NBBottomWarningTextFieldShouldChangeCharactersIn(text: String?, range: NSRange, replacementString: String?, textFieldView: NBBottomWarningTextFieldView)
}

protocol NBTextFieldBottomLabelLayoutElements: NB_ViewLayoutElements {
    var textField: NBTextFiled {get set}
    var redLabel: UILabel {get set}
}

struct NBTextFieldBottomLabelLayoutParameters {
    
}

struct NBTextFieldBottomLabelLayout: NB_ViewLayoutProtocol {
    
    typealias LayoutTarget = NBBottomWarningTextFieldView
    
    func doViewLayout(_ parent: NBBottomWarningTextFieldView) {
        
        parent.textField.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        parent.redLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalTo(parent.textField.leftView?.snp.right ?? 0)
            make.width.equalToSuperview()
            make.height.equalTo(parent.height*0.3)
        }
    }
}

@objc class NBBottomWarningTextFieldView: UIView, NBTextFieldBottomLabelLayoutElements {
    var isLayouted: Bool = false
    @objc weak var textFieldDelegate: NBBottomWarningTextFieldDelegate?
    @objc convenience init(placeholderString: String?, textColor: UIColor?, font: UIFont?, isSecureTextEntry: String?, redString: String?, redFont: UIFont?) {
        self.init(frame: .zero)
        if placeholderString != nil {
            self.placeholderString = placeholderString!
        }
        
        if textColor != nil {
            self.textColor = textColor!
        }
        
        if font != nil {
            self.font = font!
        }
        
        self.isSecureTextEntry = (isSecureTextEntry == "true" ? true:false)
        
        if redString != nil {
            self.redString = redString!
        }
        
        if redFont != nil {
            self.redFont = redFont!
        }
        
        self.addSubview(self.textField)
        self.addSubview(self.redLabel)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.viewShouldLayout() {
            let layout = NBTextFieldBottomLabelLayout()
            layout.doViewLayout(self)
            self.viewDidLayout(&self.isLayouted)
        }
    }

    @objc private func textFeildDidChanged(textField: UITextField) {
        // 输入长度限制
        if maxLength != 0 {
            textField.NBLimitInputMaxLength(maxLength)
        }
    }
    
    // MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc public var placeholderString: String = NBTextFieldBottomLabelContant.placehold {
        didSet{
            textField.placeholder = placeholderString
        }
    }
    
    var textColor: UIColor = color_assist {
        didSet{
            textField.textColor = textColor
        }
    }
    
    // 输入字符最大长度
    @objc var maxLength: Int = 0
    
    // 是否允许输入表情
    @objc var isEnableEmoji = true
    
    // 是否允许小数点
    @objc var isEnableDecimalPoint = true
    
    private var _text: String?
    @objc var text: String? {
        set {
            _text = newValue
            textField.text = _text
        }
        get {
            return textField.text
        }
    }
    
    @objc var font: UIFont = PingFangRegular(14) {
        didSet{
            textField.font = font
        }
    }
    
    var isSecureTextEntry: Bool = false {
        didSet{
            textField.isSecureTextEntry = isSecureTextEntry
        }
    }
    
    @objc var redString: String = "" {
        didSet{
            redLabel.text = redString
        }
    }
    @objc var redFont: UIFont = PingFangRegular(10) {
        didSet{
            redLabel.font = redFont
        }
    }
    
    @objc lazy var textField: NBTextFiled = {
        let internalTextField = NBTextFiled()
        internalTextField.placeholder = placeholderString
        internalTextField.isSecureTextEntry = isSecureTextEntry
        internalTextField.font = font
        internalTextField.textColor = textColor
        internalTextField.backgroundColor = .clear
        internalTextField.delegate = self
        internalTextField.addTarget(self, action: #selector(textFeildDidChanged), for: .editingChanged)
        
        return internalTextField
    }()
    
    @objc lazy internal var redLabel: UILabel = {
        let internalRedLabel = UILabel()
        internalRedLabel.isHidden = true
        internalRedLabel.text = redString
        internalRedLabel.textColor = color_main_red
        internalRedLabel.font = redFont
        internalRedLabel.backgroundColor = .clear
        return internalRedLabel
    }()

    var NB_isFirstResponder: Bool {
        return textField.isFirstResponder
    }
    
    func NB_resignFirstResponder() {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }
}

extension NBBottomWarningTextFieldView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // emoji输入限制
        if !isEnableEmoji {
            let containEmoji = string.NBContainEmoji()
            guard !containEmoji else {
                return false
            }
        }
        
        // 小数点限制输入
        if !isEnableDecimalPoint {
            let containDecimalPoint = (string == ".")
            guard !containDecimalPoint else {
                return false
            }
        }
        if (string.isEmpty) {
        } else {
            self.redLabel.isHidden = true;
        }
        
        textFieldDelegate?.NBBottomWarningTextFieldShouldChangeCharactersIn?(text: textField.text, range: range, replacementString: string, textFieldView: self)
        
        return true
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldDelegate?.NBBottomWarningTextFieldDidEndEditing(text: textField.text, textFieldView: self)
    }
}

extension String {
    // 是否包含emoji
    func NBContainEmoji() -> Bool {
        let content = self
        
        /* 包含系统中文输入法字符
         系统输入法 输入中文时content为一下数字表情
         */
        if "➋➌➏➎➍➐➑➒".contains(content) { return false }
        
        let startIndex:String.Index = content.startIndex
        let endIndex:String.Index = content.endIndex
        let strRange: Range = startIndex..<endIndex
        let range = content.range(of: "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]", options: .regularExpression, range: strRange, locale: nil)
        
        if (range != nil) {
            return true
        }
        return false
    }
}

extension UITextField {
    // 限制输入长度
    func NBLimitInputMaxLength(_ maxStringLength: Int) {
        guard let text = self.text else { return }
        guard maxStringLength > 0 else { return }
        // 需要限制输入字符长度
        guard let lang = UIApplication.shared.textInputMode?.primaryLanguage else { return }
        if lang == "zh-Hans" {
            // 中文输入
            guard let selectedRange = self.markedTextRange else {
                if text.count > maxStringLength {
                    self.text = text.substr(to: maxStringLength)
                }
                return
            }
            
            guard let _ = self.position(from: selectedRange.start, offset: 0) else { return }
            
            if text.count > maxStringLength {
                self.text = text.substr(to: maxStringLength)
            }
        } else {
            // 中文以外输入直接对其统计限制即可，不考虑其他语种情况
            if text.count > maxStringLength {
                self.text = text.substr(to: maxStringLength)
            }
        }
    }
}

