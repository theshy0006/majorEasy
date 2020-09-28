//
//  String.swift
//  majorEasy
//
//  Created by dede wang on 2019/11/13.
//  Copyright © 2019 com.zxc. All rights reserved.
//

import UIKit

//MARK:-- 多语言本地化转换方法
extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: "infoPlist", bundle: Bundle.main, value: "", comment: "")
    }
    
    func localized(withComment:String) -> String {
        return NSLocalizedString(self, tableName: "infoPlist", bundle: Bundle.main, value: "", comment: withComment)
    }
}

/*
 1，筛选一个字符数组，过滤出以“hangge”开头的字符串数组
 let array = ["hangge","com","hangge.com"]
 let filteredArray = array.filter(){
 return $0.hasPrefix("hangge")
 }
 print(filteredArray)  //["com", "hangge.com"]
 */

/*
 2，筛选一个字符数组，过滤出包含“co”字符串的字符串数组
 let array = ["hangge","com","hangge.com"]
 let filteredArray = array.filter(){
 return $0.rangeOfString("co") != nil
 }
 print(filteredArray)  //[hangge, hangge.com]
 */

//除去前后空格
//let str = str1.trimmingCharacters(in: .whitespaces)

//原始字符串
//let str1 = "<<hangge.com>>"
//删除前后<>
//let characterSet = CharacterSet(charactersIn: "<>")
//let str2 = str1.trimmingCharacters(in: characterSet)

//原始字符串
//let str1 = "欢迎访问hangge.com.com.com"
//替换后的字符串
//let str2 = str1.replacingOccurrences(of: "com", with: "COM")

extension String {
    func substr(from: Int?, to: Int?) -> String {
        if let start = from {
            guard start < self.count else {return ""}
        }
        if let end = to {
            guard end >= 0 else {return ""}
        }
        if let start = from, let end = to {
            guard end - start >= 0 else {return ""}
        }
        
        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }
        
        let endIndex: String.Index
        if let end = to, end >= 0, end < self.count {
            endIndex = self.index(self.startIndex, offsetBy: end)
        } else {
            endIndex = self.endIndex
        }
        return String(self[startIndex ..< endIndex])
    }
    
    func substr(from: Int) -> String {
        return self.substr(from: from, to: nil)
    }
    
    func substr(to: Int) -> String {
        return self.substr(from: nil, to: to)
    }
    
    func substr(from: Int?, length: Int) -> String {
        guard length > 0 else {return ""}
        let end: Int
        if let start = from, start > 0 {
            end = start + length - 1
        } else {
            end = length - 1
        }
        
        return self.substr(from: from, to: end)
    }
    
    func substr(length: Int, to: Int?) -> String {
        guard let end = to, end > 0, length > 0 else {
            return ""
        }
        
        let start: Int
        if let end = to, end - length > 0 {
            start = end - length + 1
        } else {
            start = 0
        }
        
        return self.substr(from: start, to: to)
    }
    //    常用的一些正则表达式：
    //    非中文：[^\\u4E00-\\u9FA5]
    //    非英文：[^A-Za-z]
    //    非数字：[^0-9]
    //    非中文或英文：[^A-Za-z\\u4E00-\\u9FA5]
    //    非英文或数字：[^A-Za-z0-9]
    //    非因为或数字或下划线：[^A-Za-z0-9_]
    //使用正则表达式替换
    func pregReplace(pattern: String, with: String,
                     options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange(0, self.count),
                                              withTemplate: with)
    }
    
    /// <#Description#>
    ///
    /// - Parameter find: 不忽略大小写
    /// - Returns: 是否含有特定字符串
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    /// <#Description#>
    ///
    /// - Parameter find: 忽略大小写
    /// - Returns: 是否含有特定字符串
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}

extension String {
    /// 身份证正则
    ///
    /// - Returns: true or false
    /// 身份证号的需求给出的是最后一位可以为大写的X英文字母，但是我发现即使改变options：的值，也没有区分，所以做了一个小写x返回false的判断。如果有人知道这个怎么处理，希望能留言给我，谢谢。
    func IsLegalForIDCardNumber()->Bool{
        
        let regex = "^1[0-9]{10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    /// 银行卡号正则
    ///
    /// - Returns: true or false
    func IsLegalForBankCardNumber()->Bool{
        
        let regex = "^1[0-9]{10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
        
    }
    
    /// 手机号正则
    ///
    /// - Returns: true or false
    func IsLegalForPhoneNumberInput()->Bool{
        let regex = "^1[0-9]{0,10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
        
    }
    
    /// 手机号正则(不限制长度)
    ///
    /// - Returns: true or false
    func IsLegalForPhoneNumberFullText()->Bool{
        
        let regex = "^1[0-9]{10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
        
    }
    
    /// 邮箱正则
    ///
    /// - Returns: true or false
    func IsLegalForEmail()->Bool{
        
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
        
    }

    
    /// 验证码正则
    ///
    /// - Returns: true or false
    func IsLegalForSmsCode()->Bool{
        let regex = "\\d{6}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    /// 安全码正则
    ///
    /// - Returns: true or false
    func IsLegalForSPINCode()->Bool{
        let regex = "\\d{4}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    /// 密码正则
    ///
    /// - Returns: true or false
    func IsLegalForPwd()->Bool{
        let regex = "^(?![a-z]+$)(?![A-Z]+$)(?![\\W]+$)(?![\\d]+$)\\S{8,20}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    /// 密码正则
    ///
    /// - Returns: true or false
    func IsLegalForPwdNoLength()->Bool{
        let regex = "^(?![a-z]+$)(?![A-Z]+$)(?![\\W]+$)(?![\\d]+$)\\S{0,20}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    /// 过滤emoji正则
    ///
    /// - Returns: true or false
    func isNonEmoji()->Bool{
        let regex = "[\\ud83c\\udc00-\\ud83c\\udfff]|[\\ud83d\\udc00-\\ud83d\\udfff]|[\\u2600-\\u27ff]"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    
    /// 隐藏中间(长度大于7时使用)
    func hideMiddle4() -> String {
        let length = self.lengthOfBytes(using: String.Encoding.utf8)
        if length <= 7 {//最低长度7位
            return self
        }
        let preS = self.substr(to: 3)
        let endS = self.substr(from: length - 4)
        return preS + "****" + endS
    }
    
    /// 字母和数字正则
    func isNumOrLetter() -> Bool {
        let regex = "^[A-Za-z0-9]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: self)
        return isValid
    }
    
    /// 汉字、字母、数字
    func isHanOrNumOrLetter() -> Bool {
        let regex = "^[\\u4E00-\\u9FA5A-Za-z0-9]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: self)
        return isValid
    }
    
    /// 数字、连接符以及括号的号码形式
    func isTelePhone() -> Bool {
        let regex = "^[0-9-()]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: self)
        return isValid
    }
    
    /// 替换字符串中的文字为指定符号
    ///
    /// - Parameters:
    ///   - replacementString: 替换后的符号,默认 * 号
    ///   - prefixLength: 前面要保留的位数
    ///   - suffixLength: 后面需要保留的位数
    /// - Returns:
    func replace(_ replacementString: String = "*", prefixRetainLength: Int, suffixRetainLength: Int) -> String {
        let length = self.count
    
        if length <= prefixRetainLength + suffixRetainLength {
            return self
        }
        let prefix = self.substr(to: prefixRetainLength)
        let suffix = self.substr(from: length - suffixRetainLength)
        
        let asteriskCount = length - prefixRetainLength - suffixRetainLength
        var asterisk = ""
        for _ in 0..<asteriskCount {
            asterisk.append(replacementString)
        }
        return prefix + asterisk + suffix
    }
    
    func getFitSize(maxSize: CGSize, font: UIFont? = UIFont.systemFont(ofSize: 14)) -> CGSize {
        let nsStr = NSString.init(string: self)
        let rect = nsStr.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font!], context: nil)
        return rect.size
    }
}

