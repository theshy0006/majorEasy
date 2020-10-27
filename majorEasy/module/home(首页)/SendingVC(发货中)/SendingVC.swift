//
//  SendingVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/9.
//

import UIKit

class SendingVC: BaseVC {

    let viewModel = SendingViewModel()

    @IBOutlet weak var inviteLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var sendbtn: UIButton!

    
    lazy var tableView = UITableView(frame: self.view.frame, style: .plain).then {
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.backgroundColor = color_BgColor
        $0.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        $0.estimatedRowHeight = 128.5
        $0.rowHeight = UITableView.automaticDimension
        let nib = UINib(nibName: "SendingCell", bundle: nil)
        $0.register(nib, forCellReuseIdentifier: "SendingCell")
    }
    
    override func setUpView() {
        
        let attributedString = NSMutableAttributedString(string: inviteLabel.text!)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: attributedString.length - 4, length: 4))
        inviteLabel.attributedText = attributedString
        sendbtn.layer.cornerRadius = 5
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
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(sendbtn.snp.top).offset(-10)
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
    
    func shareData(suppliesInfo: MySuppliesInfo) {
        NBShareView.showTips { index in
            print(index)
            
            let content = (suppliesInfo.loadPlaceCity ?? "") + (suppliesInfo.loadPlaceCity ?? "") + (suppliesInfo.mySupplyMsg ?? "")
            
            let url = "http://supplydetail.js56918.com/?supplyNum=" + (suppliesInfo.supplyNum ?? "")
            
            if( index == 0 ) {
                // 朋友圈
                ShareManager.shareInstance().shareWeChatFriend("大件无忧，询价调车更迅速", andContent: content, image: "", linkWith: url, shareType: .WECHATZONE, style: .cargo)
            } else {
                // 微信好友
                ShareManager.shareInstance().shareWeChatFriend("大件无忧，询价调车更迅速", andContent: content, image: "", linkWith: url, shareType: .WECHAT, style: .cargo)
            }
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
    
    @IBAction func inviteBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func sendingBtnPressed(_ sender: UIButton) {
        self.navigationController?.pushViewController(PostVC(), animated: true)
    }

}

//tableView代理实现
extension SendingVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SendingCell = tableView.dequeueReusableCell(withIdentifier: "SendingCell") as! SendingCell
        cell.selectionStyle = .none
        cell.setCellWithModel(self.viewModel.dataSource[indexPath.row])
        cell.editColsure = { [weak self] model in
            self?.navigationController?.pushViewController(PostVC(suppliesInfo:model), animated: true)
        }
        
        cell.shareColsure = { [weak self] model in
            self?.shareData(suppliesInfo:model)
        }
        // 指定司机
        cell.assignColsure = { [weak self] model in
            
        }
        
        cell.deleteColsure = { [weak self] model in
            self?.deleteData(suppliesInfo:model)
        }
        return cell
    }
    
}
