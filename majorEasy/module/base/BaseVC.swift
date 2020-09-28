//
//  BaseVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then
import GTMRefresh

class BaseVC: UIViewController {
    
    /// 设置是否隐藏导航栏 需要在ViewDidLoad()方法中设置
    var hideNavigationBar: Bool = false
    
    // MARK:-- 生命周期
    //重写初始化方法
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    //扩展一个新的初始化方法
    convenience init() {
        //获取项目名称+类名:BigSheep.XXXViewController
        let proAddNibName = type(of: self).description()
        let substringArry = proAddNibName.components(separatedBy:".")
        let nibNameOrNil = substringArry.count == 2 ? substringArry[1] : ""
        
        //nibNameOrNil = nibNameOrNil.
        //考虑到xib文件可能不存在或被删，故加入判断
        if let _ = Bundle.main.path(forResource: nibNameOrNil, ofType: "nib") {
            self.init(nibName: nibNameOrNil, bundle: nil)
        } else {
            self.init(nibName: nil, bundle: nil)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigation()
        setUpData()
        setUpView()
        self.view.backgroundColor = color_BgColor
    }
    
    func setUpView() {
    }
    
    func setUpData() {
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 统一在此设置导航栏隐藏，其他地方不应该出现任何关于navigationController?.setNavigationBarHidden的使用
        self.navigationController?.setNavigationBarHidden(hideNavigationBar, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK:-- 属性
    var emptyImageView: UIImageView?
    //var tipLabel: UILabel?
}

extension BaseVC {
    //产生空白页面
    func createEmptyResultUI() {
        if (emptyImageView == nil) {
            emptyImageView = UIImageView()
            emptyImageView?.contentMode = .scaleAspectFill
            emptyImageView?.clipsToBounds = true
            emptyImageView?.image = ImageNamed("ic_search_empty")
            self.view.addSubview(emptyImageView!)
            emptyImageView?.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview().offset(-SafeAreaTopHeight/2)
                make.centerX.equalToSuperview()
                make.width.equalTo(146.scaleX)
                make.height.equalTo(126.scaleX)
            }
        }
        
        /* 切图中自带了文字，若没有带，需要使用下面这个label
        if (tipLabel == nil) {
            tipLabel = UILabel()
            tipLabel?.textAlignment = .center
            tipLabel?.font = PingFangMedium(14)
            tipLabel?.textColor = color_assist
            tipLabel?.text = "空空如也~"
            self.view.addSubview(tipLabel!)
            tipLabel?.snp.makeConstraints { (make) in
                make.top.equalTo(self.emptyImageView!.snp.bottom).offset(20)
                make.centerX.equalTo(self.view.centerX)
                make.left.right.equalTo(self.view).inset(15)
            }
        }
         */
    }
    //移除空白页面
    func removeEmptyResultUI() {
        self.emptyImageView?.removeFromSuperview()
        //self.tipLabel?.removeFromSuperview()
        self.emptyImageView = nil
        //self.tipLabel = nil
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        get{
            return .default
        }
    }

}

