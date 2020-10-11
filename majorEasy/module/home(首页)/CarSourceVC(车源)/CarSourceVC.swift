//
//  CarSourceVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/9.
//

import UIKit

class CarSourceVC: BaseVC {

    let viewModel = CarSourceViewModel()

    lazy var sortSelectView = NBSelectView().then {
        $0.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 40)
        $0.backgroundColor = UIColor.white
    }
    
    lazy var tableView = UITableView(frame: self.view.frame, style: .plain).then {
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.backgroundColor = color_BgColor
        $0.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        $0.estimatedRowHeight = 128.5
        $0.rowHeight = UITableView.automaticDimension
        let nib = UINib(nibName: "SourceCell", bundle: nil)
        $0.register(nib, forCellReuseIdentifier: "SourceCell")
    }
    
    override func setUpView() {
        
        self.view.addSubview(self.sortSelectView)
        self.sortSelectView.setUp(sortSelectView.firstBtn, withText: "出发地")
        self.sortSelectView.setUp(sortSelectView.secondBtn, withText: "目的地")
        self.sortSelectView.setUp(sortSelectView.sortBtn, withText: "车长车型")
        
        self.sortSelectView.itemBtnBlock = { index in
            print(index)
        }
        
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
            make.top.equalTo(sortSelectView.snp.bottom)
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
        self.viewModel.getAllvehicles(success: { [weak self] in
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
extension CarSourceVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SourceCell = tableView.dequeueReusableCell(withIdentifier: "SourceCell") as! SourceCell
        cell.selectionStyle = .none
        cell.setCellWithModel(self.viewModel.dataSource[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
}
