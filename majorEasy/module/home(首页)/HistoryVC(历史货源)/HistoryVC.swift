//
//  HistoryVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/9.
//

import UIKit


class HistoryVC: BaseVC {

    let viewModel = OftenViewModel()
    
    lazy var tableView = UITableView(frame: self.view.frame, style: .plain).then {
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.backgroundColor = color_BgColor
        $0.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        $0.estimatedRowHeight = 128.5
        $0.rowHeight = UITableView.automaticDimension
        let nib = UINib(nibName: "OftenCell", bundle: nil)
        $0.register(nib, forCellReuseIdentifier: "OftenCell")
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
        self.viewModel.getMySuppliesModel(success: { [weak self] in
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
    
    func deleteData(suppliesInfo: MySuppliesInfo) {
        
        let alertController = UIAlertController(title: nil, message: "确定要删除该条信息吗？", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "取消", style: .default, handler:nil)
        let okAction = UIAlertAction(title: "确认", style: .default, handler: {
            [weak self] (ac) in
            self?.viewModel.deleteMySupplies(supplyNum:suppliesInfo.supplyNum ?? "",
                                            success: { [weak self] in
                NBLoadManager.hidLoading()
                NBHUDManager.toast("删除成功")
                self?.updateUI()
            }) { (error) in
                NBLoadManager.hidLoading()
                NBHUDManager.toast(error.message)
            }
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil) 
    }

}

//tableView代理实现
extension HistoryVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:OftenCell = tableView.dequeueReusableCell(withIdentifier: "OftenCell") as! OftenCell
        cell.selectionStyle = .none
        cell.setCellWithModel(self.viewModel.dataSource[indexPath.row])
        cell.againBtn.setTitle("编辑", for: .normal)
        cell.againColsure = { [weak self] model in
            self?.navigationController?.pushViewController(PostVC(suppliesInfo:model), animated: true)
        }
        
        cell.deleteColsure = { [weak self] model in
            self?.deleteData(suppliesInfo:model)
        }
        return cell
    }
    
}
