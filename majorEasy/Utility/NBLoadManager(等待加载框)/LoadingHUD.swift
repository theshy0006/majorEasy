//
//  LoadingHUD.swift
//  NoteBook
//
//  Created by dede wang on 2019/10/20.
//  Copyright © 2019 com.boc. All rights reserved.
//

import UIKit

let bgWidth:CGFloat = 160
let bgHight:CGFloat = 48

@objc enum LoadingHudStyle: NSInteger {
    case normal
    case cancel
}

@objc class LoadingHUD: UIView {

    var bgView: UIView!
    var bgColor: UIColor?
    var cornerRadius: CGFloat = 4.0
    var imageView: UIImageView!
    var label: UILabel!
    var cancelBtn: UIButton!
    var countDownTimer:Timer!
    var angle:CGFloat = 0
    var style:LoadingHudStyle = .normal
    
    var cancelblock:(()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, style: LoadingHudStyle) {
        self.init(frame: frame)
        self.bgColor = UIColor.white
        self.style = style
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.contentMode = .center
        
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        bgView = UIView(frame: CGRect(x: (self.width - bgWidth)/2, y: (self.height-bgHight)/2, width: bgWidth, height: bgHight))
        bgView.backgroundColor = bgColor
        bgView.layer.cornerRadius = cornerRadius
        bgView.layer.masksToBounds = true
        bgView.isUserInteractionEnabled = true
        self.addSubview(bgView)
        
        imageView = UIImageView(frame: CGRect(x: 15, y: (bgHight-24)/2, width: 24, height: 24))
        imageView.image = #imageLiteral(resourceName: "loading")
        bgView.addSubview(imageView)
        
        let labX = imageView.left + imageView.width + 10
        self.label = UILabel(frame: CGRect(x: labX, y: (bgHight-15)/2, width: bgWidth-labX-50, height: 15))
        
        self.label.backgroundColor = UIColor.clear
        self.label.text = "加载中..."
        self.label.textColor = RGBHex(0x323232)
        self.label.font = PingFangRegular(14)
        bgView.addSubview(self.label)
        
        cancelBtn = UIButton(type: .custom)
        cancelBtn.setImage(UIImage(named: "cancel"), for: .normal)
        cancelBtn.frame = CGRect(x: bgWidth-50, y: 0, width: 50, height: bgHight)
        cancelBtn.backgroundColor = UIColor.clear
        cancelBtn.addTarget(self, action:#selector(cancelClick(_:)), for:.touchUpInside)
        bgView.addSubview(self.cancelBtn)
        
        if self.style == .normal {
            cancelBtn.isHidden = true;
        }else {
            cancelBtn.isHidden = false;
        }
        show()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    func show() {
        countDownTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {_ in
            DispatchQueue.main.async {
                self.angle = self.angle + 0.5
                let transform = CGAffineTransform(rotationAngle: self.angle)
                self.imageView.transform = transform
            }
        })
    }
    
    func hide() {
        countDownTimer.invalidate()
        self.removeFromSuperview()
    }
    
    @objc func cancelClick(_ sender: UIButton) {
        hide()
        if let cancelblock = self.cancelblock {
            cancelblock()
        }
    }
}

