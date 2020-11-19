//
//  BuyCarVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/11/18.
//

import UIKit
import ZCycleView
import SDWebImage

class BuyCarVC: BaseVC {

    var cycleView:ZCycleView!
    @IBOutlet weak var bannerView: UIView!
    
    @IBOutlet weak var centerView: UIView!
    
    lazy var tableView = UITableView(frame: self.view.frame, style: .plain).then {
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.backgroundColor = color_BgColor
        $0.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let nib = UINib(nibName: "BuyCarCell", bundle: nil)
        $0.register(nib, forCellReuseIdentifier: "BuyCarCell")
    }
    
    let viewModel = BuyCarViewModel()
    
    func updateUI() {
        self.tableView.reloadData()
        if self.viewModel.dataSource.count == 0 {
            self.createEmptyResultUI()
        } else {
            self.removeEmptyResultUI()
        }
    }
    
    
    override func setUpData() {
        NBLoadManager.showLoading()
        viewModel.getHomeImages( success: {[weak self] (model) in
            guard let weakSelf = self else {return}
            NBLoadManager.hidLoading()
            weakSelf.viewModel.images = model.value
            weakSelf.initBanner()
        }) {[weak self] (error) in
            guard let weakSelf = self else {return}
            NBLoadManager.hidLoading()
            weakSelf.initBanner()
            NBHUDManager.toast(error.message)
        }
        
        viewModel.getCompanys( success: {[weak self] (model) in
            guard let weakSelf = self else {return}
            weakSelf.viewModel.dataSource = model.value
            weakSelf.updateUI()
        }) { (error) in
            NBLoadManager.hidLoading()
            NBHUDManager.toast(error.message)
        }
    }
    
    override func setUpView() {
        self.navigationItem.title = "买板车"
        self.setNavBarRightBtn(normalImage: "blackAdd", selector: #selector(gotoForward))
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(centerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    

    func initBanner() {
        self.cycleView = ZCycleView(frame: CGRect(x: 0, y: 0, width: bannerView.width, height: bannerView.height))
        self.cycleView.placeholderImage = ImageNamed("placeholder")
        cycleView.setUrlsGroup(self.viewModel.images)
        cycleView.delegate = self
        bannerView.addSubview(cycleView)
    }

}

extension BuyCarVC: ZCycleViewProtocol{
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


//tableView代理实现
extension BuyCarVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:BuyCarCell = tableView.dequeueReusableCell(withIdentifier: "BuyCarCell") as! BuyCarCell
        cell.selectionStyle = .none
        let model = self.viewModel.dataSource[indexPath.row]
        cell.companyNameLabel.text = model.companyName;
        if let url = model.companyLogoUrl {
            let url = URL(string: url)
            cell.companyImageView.sd_setImage(with: url, placeholderImage: cycleView.placeholderImage)
        } else {
            cell.companyImageView.image = ImageNamed("placeholder")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
}
