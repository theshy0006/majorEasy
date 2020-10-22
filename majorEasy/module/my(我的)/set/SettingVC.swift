//
//  SettingVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/21.
//

import UIKit

class SettingVC: BaseVC {

    let dataSource = ["修改密码", "用户使用协议", "隐私政策", "注销用户"];
    lazy var sortSelectView = NBSelectPlusView().then {
        $0.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 40)
        $0.backgroundColor = UIColor.white
    }
    
    lazy var tableView = UITableView(frame: self.view.frame, style: .plain).then {
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .singleLine
        $0.backgroundColor = color_BgColor
        $0.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
    override func setUpView() {
        self.title = "设置"
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func setUpData() {
        
    }

}

//tableView代理实现
extension SettingVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellId") ?? UITableViewCell()
        cell.selectionStyle = .none
        cell.textLabel?.text = dataSource[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.textColor = RGBHex(0x333333)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.row == 0) {
            let vc = ForgetVC()
            vc.tpyeName = "修改密码";
            self.navigationController?.pushViewController(vc, animated: true)
        } else if (indexPath.row == 1) {
            let model:ProtocolModel = ProtocolModel()
            model.title = "service".localized
            model.contentUrl = servicePath
            
            self.navigationController?.pushViewController(SimpleWebView(protocolModel: model), animated: true)
        } else if (indexPath.row == 2) {
            let model:ProtocolModel = ProtocolModel()
            model.title = "privacy".localized
            model.contentUrl = privacePath
            
            self.navigationController?.pushViewController(SimpleWebView(protocolModel: model), animated: true)
        } else if (indexPath.row == 2) {
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

