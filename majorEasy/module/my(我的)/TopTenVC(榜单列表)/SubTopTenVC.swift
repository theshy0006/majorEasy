//
//  SubTopTenVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/25.
//

import UIKit

class SubTopTenVC: BaseVC {

    var viewModel = TopTenViewModel()
    
    var type = 0
    var rank = 1
    
    convenience init(type: Int, rank: Int) {
        self.init()
        self.type = type
        self.rank = rank
    }
    
    lazy var tableView = UITableView(frame: self.view.frame, style: .plain).then {
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .singleLine
        $0.backgroundColor = color_BgColor
        $0.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let nib = UINib(nibName: "TopTenCell", bundle: nil)
        $0.register(nib, forCellReuseIdentifier: "TopTenCell")
    }
    
    override func setUpView() {
        
        
        self.tableView.gtm_addRefreshHeaderView(refreshHeader: WechatRefreshHeader()) {
            [weak self] in
            self?.viewModel.pageNum = 1
            self?.viewModel.loadMore = false
            self?.getOrderList()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
                self?.tableView.endRefreshing(isSuccess: true)
            }
        }
        
        self.tableView.gtm_addLoadMoreFooterView {
            [weak self] in
            self?.viewModel.loadMore = true
            self?.getOrderList()
        }
        
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func setUpData() {
        //初始化数据
        self.viewModel.rank = rank
        getOrderList()
    }
    
    func updateUI() {
        self.tableView.reloadData()
        if self.viewModel.dataSource.count == 0 {
            self.createEmptyResultUI()
        } else {
            self.removeEmptyResultUI()
        }
    }

    func getOrderList() {
        NBLoadManager.showLoading()
        
        
        if( type == 0 ) {
            self.viewModel.getInviteList(success: { [weak self] in
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
        } else if ( type == 1 ) {
            self.viewModel.getIntegralList(success: { [weak self] in
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
        } else {
            self.viewModel.getRechargeList(success: { [weak self] in
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
    }

}

//tableView代理实现
extension SubTopTenVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TopTenCell = tableView.dequeueReusableCell(withIdentifier: "TopTenCell") as! TopTenCell
        cell.selectionStyle = .none
        cell.setCellWithModel(self.viewModel.dataSource[indexPath.row], type:type)
        
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) {
            cell.topLabel.isHidden = true
            cell.topView.isHidden = false
            if (indexPath.row == 0) {
                cell.topView.image = ImageNamed("paihangbang1")
            } else if (indexPath.row == 1) {
                cell.topView.image = ImageNamed("paihangbang2")
            } else {
                cell.topView.image = ImageNamed("paihangbang3")
            }
            
        } else {
            cell.topView.isHidden = true
            cell.topLabel.isHidden = false
            cell.topLabel.text = "\(indexPath.row + 1)"
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    


}
