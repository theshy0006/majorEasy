//
//  WithDrawVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/27.
//

import UIKit

class WithDrawVC: BaseVC {

    let viewModel = WithDrawViewModel()

    lazy var tableView = UITableView(frame: self.view.frame, style: .plain).then {
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .singleLine
        $0.backgroundColor = color_BgColor
        $0.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let nib = UINib(nibName: "WithDrawCell", bundle: nil)
        $0.register(nib, forCellReuseIdentifier: "WithDrawCell")
    }
    
    override func setUpView() {
        self.viewModel.pageNum = 1
        self.viewModel.loadMore = false
        self.getOrderList()
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
            make.top.left.right.equalToSuperview()
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
        self.viewModel.getWithDraw(success: { [weak self] in
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
extension WithDrawVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:WithDrawCell = tableView.dequeueReusableCell(withIdentifier: "WithDrawCell") as! WithDrawCell
        cell.selectionStyle = .none
        cell.setCellWithModel(self.viewModel.dataSource[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
}

