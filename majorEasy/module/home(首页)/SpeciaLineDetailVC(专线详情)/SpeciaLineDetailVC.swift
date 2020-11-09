//
//  SpeciaLineDetailVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/6.
//

import UIKit
import ZCycleView
import SDWebImage

class SpeciaLineDetailVC: BaseVC {

    @IBOutlet weak var bannerView: UIView!
    
    var cycleView:ZCycleView!
    
    @IBOutlet weak var lineNameLabel: UILabel!
    
    @IBOutlet weak var timesLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    
    private var lineId = ""
    let viewModel = LineDetailViewModel()
    
    convenience init(lineId: String) {
        self.init()
        self.lineId = lineId
    }
    
    override func setUpView() {
        self.view.backgroundColor = RGBHex(0xF6F6F6)
        self.navigationItem.title = "专线详情"
    }
    
    override func setUpData() {
        NBLoadManager.showLoading()
        viewModel.getDetail(lineId:self.lineId, success: {[weak self] (model) in
            guard let weakSelf = self else {return}
            NBLoadManager.hidLoading()
            weakSelf.initWithInfo(model: model.value)
        }) { (error) in
            NBLoadManager.hidLoading()
            NBHUDManager.toast(error.message)
        }
    }
    
    func initWithInfo(model: DedicatedLineDetailInfo) {
        print(model)
        
        lineNameLabel.text = (model.loadPlace ?? "") + "->" + (model.unloadPlace ?? "")
        timesLabel.text = "运输时效："+"\(model.transportDays)"
        phoneLabel.text = model.contactMobile
        addressLabel.text = model.companyAddress
        typeLabel.text = String(format:"%.2f",model.heavyUnitPrice) + "/吨 " + String(format:"%.2f",model.bubbleUnitPrice) + "/方"
        self.viewModel.images = model.advertPics ?? []
        self.initBanner()
    }
    
    
    func initBanner() {
        self.cycleView = ZCycleView(frame: CGRect(x: 0, y: 0, width: bannerView.width, height: bannerView.height))
        self.cycleView.placeholderImage = ImageNamed("placeholder")
        cycleView.setUrlsGroup(self.viewModel.images)
        cycleView.delegate = self
        bannerView.addSubview(cycleView)
    }
    
    @IBAction func callPhoneBtnPressed(_ sender: UIButton) {
        NBUtility.showTelephone(phoneLabel.text ?? "")
    }
    
    
}

extension SpeciaLineDetailVC: ZCycleViewProtocol{
    func cycleViewConfigureDefaultCellImageUrl(_ cycleView: ZCycleView, imageView: UIImageView, imageUrl: String?, index: Int) {
        if let url = imageUrl {
            let url = URL(string: url)
            imageView.sd_setImage(with: url, placeholderImage: cycleView.placeholderImage)
        } else {
            imageView.image = ImageNamed("placeholder")
        }
    }
    func cycleViewConfigurePageControl(_ cycleView: ZCycleView, pageControl: ZPageControl) {
        pageControl.pageIndicatorTintColor = tabbarFontNormalColor
        pageControl.currentPageIndicatorTintColor = UIColor.white
    }

}
