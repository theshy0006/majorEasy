//
//  MyCardVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/11/10.
//

import UIKit

class MyCardVC: BaseVC {

    let viewModel = MyCardViewModel()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getMyCard(success: { [weak self] in
            NBLoadManager.hidLoading()
            self?.tableView.endLoadMore(isNoMoreData:true)
            self?.updateUI()
        }) { (error) in
            NBLoadManager.hidLoading()
            NBHUDManager.toast(error.message)
        }
    }
    
    lazy var tableView = UITableView(frame: self.view.frame, style: .plain).then {
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.backgroundColor = UIColor.white
        $0.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let nib = UINib(nibName: "MyCardCell", bundle: nil)
        $0.register(nib, forCellReuseIdentifier: "MyCardCell")
    }
    
    lazy var addButton = UIButton().then {
        $0.setTitle("添加银行卡", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = tabbarFontSelectColor;
        $0.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let weakself = self else {
                return
            }
            weakself.navigationController?.pushViewController(AddCard(), animated: true)
        }).disposed(by: disposeBag)
    }
    
    override func setUpView() {
        self.view.backgroundColor = UIColor.white
        self.title = "银行卡"
        self.getOrderList()
        self.tableView.gtm_addRefreshHeaderView(refreshHeader: WechatRefreshHeader()) {
            [weak self] in
            self?.getOrderList()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
                self?.tableView.endRefreshing(isSuccess: true)
            }
        }
        self.view.addSubview(self.addButton)
        self.view.addSubview(self.tableView)
        self.addButton.addShadow(RGBHex(0xe2e2e2))
        self.addButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(15.scaleX)
            make.bottom.equalToSuperview().offset(-SafeAreaBottomHeight-15)
            make.height.equalTo(44)
        }
        
        self.tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(self.addButton.snp.top).offset(-15)
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
        self.viewModel.getMyCard(success: { [weak self] in
            NBLoadManager.hidLoading()
            self?.tableView.endLoadMore(isNoMoreData:true)
            self?.updateUI()
        }) { (error) in
            NBLoadManager.hidLoading()
            NBHUDManager.toast(error.message)
        }
    }

}

//tableView代理实现
extension MyCardVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MyCardCell = tableView.dequeueReusableCell(withIdentifier: "MyCardCell") as! MyCardCell
        cell.selectionStyle = .none
        cell.setCellWithModel(self.viewModel.dataSource[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
            return "删除"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
        if editingStyle == .delete {
            self.viewModel.delete(item: self.viewModel.dataSource[indexPath.row]) {
            } failure: { (error) in
                NBHUDManager.toast(error.message)
            }

            self.viewModel.dataSource.remove(at: indexPath.row)
                //刷新tableview
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
            
}
