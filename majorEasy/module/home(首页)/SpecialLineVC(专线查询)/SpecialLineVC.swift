//
//  SpecialLineVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/5.
//

import UIKit

class SpecialLineVC: BaseVC {

    @IBOutlet weak var fromButton: UIButton!
    
    @IBOutlet weak var toButton: UIButton!
    
    @IBAction func fromButtonPressed(_ sender: UIButton) {
        self.chooseAreaView.show()
        chooseAreaView.myColsure = { [weak self] (cityName, cityId) in
            print(cityName)
            print(cityId)
            self?.fromButton.setTitle(cityName, for: .normal)
            self?.viewModel.loadPlaceCode = cityId.substr(from: cityId.count-6, to: nil)
        }
        
    }
    
    @IBAction func toButtonPressed(_ sender: Any) {
        self.chooseAreaView.show()
        chooseAreaView.myColsure = { [weak self] (cityName, cityId) in
            print(cityName)
            print(cityId)
            self?.toButton.setTitle(cityName, for: .normal)
            self?.viewModel.unloadPlaceCode = cityId.substr(from: cityId.count-6, to: nil)
        }
    }
    
    @IBOutlet weak var topView: UIView!
    
    let viewModel = SpecialLineViewModel()
    
    lazy var chooseAreaView = NBCitySelectView(frame: CGRect(x: 0, y: kScreenH/4, width: kScreenW, height: 3*kScreenH/4 - SafeAreaBottomHeight - TabBarHeight)).then {
        $0.backgroundColor = .white
    }
    
    lazy var tableView = UITableView(frame: self.view.frame, style: .plain).then {
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.backgroundColor = color_BgColor
        $0.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let nib = UINib(nibName: "SpecialLineCell", bundle: nil)
        $0.register(nib, forCellReuseIdentifier: "SpecialLineCell")
    }
    
    override func setUpView() {
        self.view.backgroundColor = RGBHex(0xF6F6F6)
        self.navigationItem.title = "专线查询"
        self.setNavBarRightBtn(normalImage: "blackAdd", selector: #selector(gotoForward))
        self.tableView.gtm_addRefreshHeaderView(refreshHeader: WechatRefreshHeader()) {
            [weak self] in
            self?.viewModel.pageNum = 1
            self?.viewModel.loadMore = false
            self?.getDedicatedLines()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
                self?.tableView.endRefreshing(isSuccess: true)
            }
        }
        
        self.tableView.gtm_addLoadMoreFooterView {
            [weak self] in
            self?.viewModel.loadMore = true
            self?.getDedicatedLines()
        }
        
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    override func setUpData() {
        //初始化数据
        getDedicatedLines()
    }
    
    func updateUI() {
        self.tableView.reloadData()
        if self.viewModel.dataSource.count == 0 {
            self.createEmptyResultUI()
        } else {
            self.removeEmptyResultUI()
        }
    }

    func getDedicatedLines() {
        NBLoadManager.showLoading()
        let lat = "\(BaiduMapManager.shared().userLocation.location.coordinate.latitude)"
        let lng = "\(BaiduMapManager.shared().userLocation.location.coordinate.longitude)"
        print(lat)
        print(lng)
        let location = lng + "," + lat
        self.viewModel.getDedicatedLines(location: location, success: { [weak self] in
            NBLoadManager.hidLoading()
            if( self?.viewModel.pageNum == -1 ) {
                self?.tableView.endLoadMore(isNoMoreData:true)
            } else {
                self?.tableView.endLoadMore(isNoMoreData:false)
            }
            
            self?.updateUI()
        }) { (error) in
            NBLoadManager.hidLoading()
            NBHUDManager.toast(error.message)
        }
    }
    
    override func gotoForward() {
        print("哈哈")
    }

}

//tableView代理实现
extension SpecialLineVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SpecialLineCell = tableView.dequeueReusableCell(withIdentifier: "SpecialLineCell") as! SpecialLineCell
        cell.selectionStyle = .none
        cell.setCellWithModel(self.viewModel.dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 157
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(SpeciaLineDetailVC(lineId: self.viewModel.dataSource[indexPath.row].dedicatedLineNum ?? ""), animated: true)
    }
}
