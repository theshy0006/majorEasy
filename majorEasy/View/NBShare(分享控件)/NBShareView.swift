//
//  NBShareView.swift
//  NoteBook
//
//  Created by dede wang on 2019/10/30.
//  Copyright © 2019 com.boc. All rights reserved.
//

/*

 用法演示：
 NBShareView.showTips(callBack: {(row) -> () in
     print(row)
 })
 
 */



import UIKit
import RxCocoa

var currentShareView: NBShareView?

@objc class NBShareView: UIView {

    var cover: NBCovor?

    static var didSelectRowAt:((_ row: Int)->())?
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 170))
        initView()
        layoutViews()
        initScroll()
        loadAnimate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        self.addSubview(cancleButton)
        self.addSubview(splitline)
        self.addSubview(topScrollView)
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.backgroundColor = .white
    }
    
    func initScroll() {
        let imgArrary = ["alishq_allshare_60x60_", "weixin_allshare_60x60_"]
        let titleArray = ["微信朋友圈", "微信好友"]
        setScrollViewContent(withScrollView: topScrollView, imgArray: imgArrary, titleArray: titleArray)
    }
    
    func loadAnimate() {
        var delay: TimeInterval = 0
        var i: TimeInterval = 0
        for subview in self.allSubviews() {
            if subview is NBShareButton {
                if i == 5 {
                    delay = 0
                }
                delay += 0.05
                i += 1
                
                if let btn = subview as? NBShareButton {
                    btn.shakeBtn(delay: delay)
                }
            }
        }
    }
    
    fileprivate func setScrollViewContent(withScrollView scrollView: UIScrollView, imgArray: [String], titleArray: [String]) {
        
        let btnW: CGFloat = 76
        let btnH: CGFloat = 90
        let btnY: CGFloat = 23
        let margin: CGFloat = (kScreenW - 152) / 3
        var btnX: CGFloat = 0
        let space: CGFloat = (kScreenW - (margin * 2) - (btnW * 2));
        
        for (index, value) in imgArray.enumerated() {
            
            btnX = (btnW + space) * CGFloat(index) + margin
            
            let btn = NBShareButton(type: .custom)
            btn.frame = CGRect.init(x: btnX, y: btnY, width: btnW, height: btnH)
            btn.setImage(UIImage.init(named: value), for: .normal)
            btn.setTitle(titleArray[index], for: .normal)
            btn.tag = index
            scrollView.addSubview(btn)
            btn.rx.tap.subscribe(onNext: { [weak self] _ in
                guard let weakself = self else {return}
                guard let cover = weakself.cover else {return}
                cover.hideCover({
                    if let didSelectRowAt = NBShareView.didSelectRowAt {
                        didSelectRowAt(btn.tag)
                    }
                })
                
                
                
            }).disposed(by: disposeBag)
            if index == imgArray.count - 1 {
                scrollView.contentSize = CGSize.init(width: btn.frame.maxX + margin, height: btnH)
            }
        }
    }
    
    private func layoutViews() {
        cancleButton.snp.makeConstraints { (make) -> Void in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        splitline.snp.makeConstraints { (make) -> Void in
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
            make.bottom.equalTo(cancleButton.snp.top)
        }

        topScrollView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalToSuperview()
            make.height.equalTo(126)
            make.bottom.equalTo(cancleButton.snp.top)
        }
    }

    lazy var topScrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    lazy var splitline: UIView = {
        let view = UIView()
        view.backgroundColor = color_sperator
        return view
    }()
    
    lazy var cancleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("取消", for: .normal)
        button.setTitleColor(RGBHex(0x666666), for: .normal)
        button.titleLabel?.font = PingFangRegular(15)
        button.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let weakself = self else {return}
            weakself.hide()
        }).disposed(by: disposeBag)
        return button
    }()
    
    func show() {
        cover = NBCovor.init(contentView: self, animStyle: .bottom)
    }
    
    func hide() {
        guard let cover = self.cover else {return}
        cover.hideCover({
        })
    }
    
    @objc class func showTips(callBack:  @escaping (_ row: Int) -> Void) {
        currentShareView = NBShareView.init(frame: CGRect.zero)
        currentShareView?.show()
        didSelectRowAt = callBack
    }
}
