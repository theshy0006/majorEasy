//
//  ShopVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/11/19.
//

import UIKit

class ShopVC: BaseVC {

    let viewModel = ShopViewModel()

    @IBOutlet weak var searchBar: UISearchBar!
    
    lazy var tableView = UITableView(frame: self.view.frame, style: .plain).then {
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.backgroundColor = color_BgColor
        $0.estimatedRowHeight = 128.5
        $0.rowHeight = UITableView.automaticDimension
        $0.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let nib = UINib(nibName: "ShopCell", bundle: nil)
        $0.register(nib, forCellReuseIdentifier: "ShopCell")
    }
    
    override func setUpView() {
        
        self.view.addSubview(self.searchBar)
        
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
            make.top.equalTo(searchBar.snp.bottom).offset(1)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func setUpData() {
        //初始化数据
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
        self.viewModel.getSuppliesByParam(success: { [weak self] in
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

//tableView代理实现
extension ShopVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ShopCell = tableView.dequeueReusableCell(withIdentifier: "ShopCell") as! ShopCell
        cell.selectionStyle = .none
        cell.setCellWithModel(self.viewModel.dataSource[indexPath.row])

        return cell
    }
    
}
