//
//  UIView.swift
//  majorEasy
//
//  Created by dede wang on 2018/12/6.
//  Copyright © 2018 dede wang. All rights reserved.
//

/*
 纯代码自定义View的方法
 @implementation CustomUIView

 // 步骤 1：重写initWithFrame:方法，创建子控件并 - 添加
 - (instancetype)initWithFrame:(CGRect)frame {
     
     self = [super initWithFrame:frame];
     if (self) {
         
         UILabel *lable = [[UILabel alloc] init];
         self.lable = lable;
         [self addSubview:lable];
     }
     return self;
 }
 // 步骤 2：重写layoutSubviews，子控件设置frame
 - (void)layoutSubviews {
     
     [super layoutSubviews];
     CGSize size = self.frame.size;
     self.lable.frame = CGRectMake(0, 0, size.width * 0.5, size.height * 0.5);
 }
 // 步骤 4： 子控件赋值
 - (void)setModel:(CustomUIViewModel *)model {
     
     _model = model;
     self.lable.text = model.name;
 }

 @end
 */







import UIKit

//为 uiview 扩展添加边框功能
extension UIView {
    
    func addShadow(_ theColor: UIColor) {
        // 阴影颜色
        layer.shadowColor = theColor.cgColor
        // 阴影偏移，默认(0, -3)
        layer.shadowOffset = CGSize(width: 0, height: 0)
        // 阴影透明度，默认0
        layer.shadowOpacity = 0.9
        // 阴影半径，默认3
        layer.shadowRadius = 6
        layer.cornerRadius = 6
    }
    
    
    
    //返回该view所在VC
    func firstViewController() -> UIViewController? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self){
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
    
    // MARK: - 常用位置属性
    public var left:CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newLeft) {
            var frame = self.frame
            frame.origin.x = newLeft
            self.frame = frame
        }
    }
    
    public var top:CGFloat {
        get {
            return self.frame.origin.y
        }
        
        set(newTop) {
            var frame = self.frame
            frame.origin.y = newTop
            self.frame = frame
        }
    }
    
    public var width:CGFloat {
        get {
            return self.frame.size.width
        }
        
        set(newWidth) {
            var frame = self.frame
            frame.size.width = newWidth
            self.frame = frame
        }
    }
    
    public var height:CGFloat {
        get {
            return self.frame.size.height
        }
        
        set(newHeight) {
            var frame = self.frame
            frame.size.height = newHeight
            self.frame = frame
        }
    }
    
    public var right:CGFloat {
        get {
            return self.left + self.width
        }
        set(newRight) {
            var frame = self.frame
            frame.origin.x = newRight - frame.width
            self.frame = frame
        }
    }
    
    public var bottom:CGFloat {
        get {
            return self.top + self.height
        }
    }
    
    public var centerX:CGFloat {
        get {
            return self.center.x
        }
        
        set(newCenterX) {
            var center = self.center
            center.x = newCenterX
            self.center = center
        }
    }
    
    public var centerY:CGFloat {
        get {
            return self.center.y
        }
        
        set(newCenterY) {
            var center = self.center
            center.y = newCenterY
            self.center = center
        }
    }
    
    //画线
    private func drawBorder(rect:CGRect,color:UIColor){
        let line = UIBezierPath(rect: rect)
        let lineShape = CAShapeLayer()
        lineShape.path = line.cgPath
        lineShape.fillColor = color.cgColor
        self.layer.addSublayer(lineShape)
    }
    
    //设置右边框
    public func rightBorder(width:CGFloat,borderColor:UIColor){
        let rect = CGRect(x: 0, y: self.frame.size.width - width, width: width, height: self.frame.size.height)
        drawBorder(rect: rect, color: borderColor)
    }
    //设置左边框
    public func leftBorder(width:CGFloat,borderColor:UIColor){
        let rect = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        drawBorder(rect: rect, color: borderColor)
    }
    
    //设置上边框
    public func topBorder(width:CGFloat,borderColor:UIColor){
        let rect = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        drawBorder(rect: rect, color: borderColor)
    }
    
    
    //设置底边框
    public func buttomBorder(width:CGFloat,borderColor:UIColor){
        let rect = CGRect(x: 0, y: self.frame.size.height-width, width: self.frame.size.width, height: width)
        drawBorder(rect: rect, color: borderColor)
    }
    
    //利用CAShapeLayer和UIBezierPath绘制圆角
    public func cornerRadius(cornerSize:Int) {
        let rect = self.bounds
        let radio = CGSize(width: cornerSize, height: cornerSize) // 圆角尺寸
        let corner = UInt8(UIRectCorner.topLeft.rawValue) | UInt8(UIRectCorner.topRight.rawValue) | UInt8(UIRectCorner.bottomLeft.rawValue) | UInt8(UIRectCorner.bottomRight.rawValue)// 这只圆角位置
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.RawValue(corner)), cornerRadii: radio)
        let masklayer = CAShapeLayer() // 创建shapelayer
        masklayer.frame = self.bounds
        masklayer.path = path.cgPath // 设置路径
        self.layer.mask = masklayer
    }
    
    //利用CAShapeLayer和UIBezierPath绘制左边圆角
    public func leftCornerRadius(cornerSize:Int) {
        let rect = self.bounds
        let radio = CGSize(width: cornerSize, height: cornerSize) // 圆角尺寸
        let corner = UInt8(UIRectCorner.topLeft.rawValue) | UInt8(UIRectCorner.bottomLeft.rawValue) // 这只圆角位置
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.RawValue(corner)), cornerRadii: radio)
        let masklayer = CAShapeLayer() // 创建shapelayer
        masklayer.frame = self.bounds
        masklayer.path = path.cgPath // 设置路径
        self.layer.mask = masklayer
    }
    
    // MARK: - 处理渐变色
    public func renderView(TColor: UIColor, BColor: UIColor) {
        //将颜色和颜色的位置定义在数组内
        let gradientColors: [CGColor] = [TColor.cgColor, BColor.cgColor]
        //创建并实例化
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        //(这里的起始和终止位置就是按照坐标系,四个角分别是左上(0,0),左下(0,1),右上(1,0),右下(1,1))
        //渲染的起始位置
        gradientLayer.startPoint =  CGPoint(x: 0, y: 0)
        //渲染的终止位置
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        //设置frame和插入view的layer
        gradientLayer.frame = self.layer.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func allSubviews() -> [UIView] {
        var res = self.subviews //1,2   3,4
        for subview in self.subviews {
            // subview = 1
            let riz = subview.allSubviews()
            // riz = 3,4
            res.append(contentsOf: riz)
        }
        return res
    }
    
    func removeAllSubviews() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
}
