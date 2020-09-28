//
//  NBMultiSheet.swift
//  TanCheng
//
//  Created by wangyang on 2019/11/29.
//  Copyright © 2019 bocweb. All rights reserved.
//

import UIKit

var currentMultiSheet: NBMultiSheet?

class NBMultiSheet: UIView {
        
        var cover:NBCovor?
        var selectModel: Bool = false
        var style: String = "mul"
        static var didSelectRows:((_ cars: String)->())?
        
        lazy var topView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.white
            return view
        }()
        
        lazy var lineView: UIView = {
            let view = UIView()
            view.backgroundColor = color_sperator
            return view
        }()
    
        lazy var okButton: UIButton = {
            let button = UIButton(type: .custom)
            button.setTitle("确定", for: .normal)
            button.setTitleColor(color_main_blue, for: .normal)
            button.titleLabel?.font = PingFangRegular(16)
            button.rx.tap.subscribe(onNext: { [weak self] _ in
                guard let weakself = self else {return}
                guard let items = weakself.itemInfos else {return}
                guard let cover = weakself.cover else {return}
                
                var string = ""
                for item in items {
                    if (item.imageName == "check") {
                        string += "\(item.title),"
                    }
                }
                cover.hideCover({
                    if let didSelectRowAt = NBMultiSheet.didSelectRows {
                        didSelectRowAt(string)
                    }
                })
            }).disposed(by: disposeBag)
            return button
        }()
    
        lazy var allButton: UIButton = {
            let button = UIButton(type: .custom)
            button.setTitle("全选", for: .normal)
            button.setTitleColor(color_main_blue, for: .normal)
            button.titleLabel?.font = PingFangRegular(16)
            button.rx.tap.subscribe(onNext: { [weak self] _ in
                guard let weakself = self else {return}
                guard let cover = weakself.cover else {return}
                weakself.selectModel = !weakself.selectModel
                if (weakself.selectModel) {
                    weakself.selectAllItem()
                } else {
                    weakself.clearAllItem()
                }

                weakself.tableView.reloadData()
            }).disposed(by: disposeBag)
            return button
        }()
        
        private lazy var tableView: UITableView = {
            let table = UITableView()
            table.rowHeight = kItemH
            table.separatorStyle = .singleLine
            table.separatorColor = color_sperator
            table.isScrollEnabled = true
            table.dataSource = self
            table.delegate = self
            table.showsVerticalScrollIndicator = false
            table.register(cellWithClass: NBActionSheetViewCell.self)
            return table
        }()
        
        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.textColor = RGBHex(0x333333)
            label.font = PingFangRegular(16.0)
            return label
        }()
        
        var itemInfos: Array<NBActionSheetItem>?
        
        override init(frame: CGRect) {
            super.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        }

        convenience init(title: String, style: String, itemInfos: Array<NBActionSheetItem>?) {
            self.init(frame: CGRect.zero)
            
            self.addSubview(self.topView)
            self.topView.addSubview(self.titleLabel)
            self.topView.addSubview(lineView)
            self.topView.addSubview(self.okButton)
            self.topView.addSubview(self.allButton)
            
            self.addSubview(tableView)
            layoutViews()
            self.titleLabel.text = title
            self.itemInfos = itemInfos
            self.style = style
            if (style != "mul") {
                self.allButton.isHidden = true
                self.okButton.isHidden = true
            }
            
        }

        
    @objc class func showActionSheet(title: String, style: String, itemInfos: Array<NBActionSheetItem>?, callBack:  @escaping (_ cars: String) -> Void) {
        currentMultiSheet = NBMultiSheet.init(title: title, style: style, itemInfos: itemInfos)
            currentMultiSheet?.show()
            didSelectRows = callBack
        }
        
        func updateActionSheetItemWithIndex(index: Int, item: NBActionSheetItem) {
            guard let items = self.itemInfos else {return}
            if items.count > index {
                self.itemInfos?[index] = item
                tableView.reloadData()
            }
        }
        
        func selectAllItem () {
            guard let items = self.itemInfos else {return}
            for item in items {
                item.imageName = "check"
            }
        }
    
        func clearAllItem () {
            guard let items = self.itemInfos else {return}
            for item in items {
                item.imageName = "uncheck"
            }
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: - 设置约束
        private func layoutViews() {

            //
            topView.snp.makeConstraints { (make) -> Void in
                make.left.right.top.equalToSuperview()
                make.height.equalTo(kTopH)
            }
            
            //
            titleLabel.snp.makeConstraints { (make) -> Void in
                make.center.equalTo(self.topView)
                make.width.greaterThanOrEqualTo(50)
                make.top.bottom.equalToSuperview().inset(5)
            }
            
            okButton.snp.makeConstraints { (make) -> Void in
                make.top.right.equalToSuperview()
                make.width.equalTo(60)
                make.height.equalTo(kTopH)
            }
            
            allButton.snp.makeConstraints { (make) -> Void in
                make.top.left.equalToSuperview()
                make.width.equalTo(60)
                make.height.equalTo(kTopH)
            }
            
            //
            lineView.snp.makeConstraints { (make) -> Void in
                make.bottom.left.right.equalToSuperview()
                make.height.equalTo(0.5)
            }
            
            //
            tableView.snp.makeConstraints { (make) -> Void in
                make.right.left.bottom.equalToSuperview()
                make.top.equalTo(topView.snp.bottom)
            }

        }
        
        func show() {
            guard let items = self.itemInfos else {return}
            let bgView = UIView()
            bgView.backgroundColor = UIColor.white
            bgView.addSubview(self)
            let relaityH = CGFloat(items.count) * kItemH + kTopH
            let height = relaityH > kMaxH ? kMaxH : relaityH;
            
            self.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: height)
            bgView.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: height+SafeAreaBottomHeight)
            
            cover = NBCovor.init(contentView: bgView)
        }
        
    }

    extension NBMultiSheet: UITableViewDelegate, UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            guard let items = self.itemInfos else {return 0}
            return items.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withClass: NBActionSheetViewCell.self)
            if let items = self.itemInfos {
                cell.setCellContent(item: items[indexPath.row])
            }
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            guard let items = self.itemInfos else {return}
            if (style != "mul") {
                self.clearAllItem()
                self.tableView.reloadData()
                let item = items[indexPath.row]
                item.imageName = "check"
                UIView.performWithoutAnimation {
                    self.tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
                    
                }
                
                var string = ""
                for item in items {
                    if (item.imageName == "check") {
                        string += "\(item.title),"
                    }
                }
                self.cover?.hideCover({
                    if let didSelectRowAt = NBMultiSheet.didSelectRows {
                        didSelectRowAt(string)
                    }
                })

            } else {
                let item = items[indexPath.row]
                if item.enabled {
                    if (item.imageName == "uncheck") {
                        item.imageName = "check"
                    } else {
                        item.imageName = "uncheck"
                    }
                    UIView.performWithoutAnimation {
                        self.tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
                    }
                }
            } 
        }
}
