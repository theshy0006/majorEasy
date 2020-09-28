//
//  NBActionSheet.swift
//  acorn
//
//  Created by dede on 2019/3/15.
//  Copyright © 2019 dede. All rights reserved.
//
/*
 用法演示:
 NBActionSheet.showActionSheet(title: "尼玛的", itemInfos: [item1, item2, item3, item4, item5, item6], callBack: { (row, item) -> () in
 print(row)
 print(item)
 })
*/

import UIKit

let kMaxH =  ScreenWidth
let kItemH = 100.0 / 750.0 * ScreenWidth
let kTopH = 90.0 / 750.0 * ScreenWidth

var currentActionSheet: NBActionSheet?



@objc class NBActionSheet: UIView {
    
    var cover:NBCovor?

    static var didSelectRowAt:((_ row: Int, _ item: NBActionSheetItem)->())?
    
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

    convenience init(title: String, itemInfos: Array<NBActionSheetItem>?) {
        self.init(frame: CGRect.zero)
        
        self.addSubview(self.topView)
        self.topView.addSubview(self.titleLabel)
        self.topView.addSubview(lineView)
        self.addSubview(tableView)
        layoutViews()
        self.titleLabel.text = title
        self.itemInfos = itemInfos
    }

    
    @objc class func showActionSheet(title: String, itemInfos: Array<NBActionSheetItem>?, callBack:  @escaping (_ row: Int, _ item: NBActionSheetItem) -> Void) {
        currentActionSheet = NBActionSheet.init(title: title, itemInfos: itemInfos)
        currentActionSheet?.show()
        didSelectRowAt = callBack
    }
    
    func updateActionSheetItemWithIndex(index: Int, item: NBActionSheetItem) {
        guard let items = self.itemInfos else {return}
        if items.count > index {
            self.itemInfos?[index] = item
            tableView.reloadData()
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
            make.centerY.equalTo(self.topView)
            make.left.right.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(5)
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

extension NBActionSheet: UITableViewDelegate, UITableViewDataSource {
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
        let item = items[indexPath.row]
        if item.enabled {
            guard let cover = self.cover else {return}
            cover.hideCover({
                if let didSelectRowAt = NBActionSheet.didSelectRowAt {
                    didSelectRowAt(indexPath.row, item)
                }
            })
        }
    }
}
