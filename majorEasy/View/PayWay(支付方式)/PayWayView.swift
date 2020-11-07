//
//  PayWayView.swift
//  majorEasy
//
//  Created by wangyang on 2020/11/7.
//
import UIKit

var currentView: PayWayView?

class PayWayView: UIView {
    
    var cover:NBCovor?
    
    var selectedIndexPath: IndexPath?

    static var didSelectRowAt:((_ item: PayWayModel)->())?
    
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
        table.register(cellWithClass: UITableViewCell.self)
        return table
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = RGBHex(0x333333)
        label.font = PingFangRegular(16.0)
        return label
    }()
    
    lazy var okButton: UIButton = {
        let button = UIButton()
        button.setTitle("确认支付", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = tabbarFontSelectColor
        button.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let weakself = self else {return}
            guard let cover = weakself.cover else {return}
            
            let row = weakself.selectedIndexPath?.row
            cover.hideCover({
                if let didSelectRowAt = PayWayView.didSelectRowAt {
                    didSelectRowAt(weakself.itemInfos[row ?? 0])
                }
            })
        }).disposed(by: disposeBag)
        return button
    }()
    
    var itemInfos = [PayWayModel]()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
    }

    convenience init() {
        self.init(frame: CGRect.zero)
        self.addSubview(self.topView)
        self.topView.addSubview(self.titleLabel)
        self.topView.addSubview(lineView)
        self.selectedIndexPath = IndexPath(row: 0, section: 0)
        
        self.addSubview(tableView)
        self.addSubview(okButton)
        layoutViews()
        self.titleLabel.text = "选择支付方式"
        let model0 = PayWayModel(imgName: "ic_pay_ballet", name: "余额支付", detail: "账户余额：\(String(format:"%.2f",DataCenterManager.default.myInfo.balance))元")
        let model1 = PayWayModel(imgName: "ic_pay_wx", name: "微信支付", detail: "亿万用户的选择，更快更安全")
        self.itemInfos.append(model0)
        self.itemInfos.append(model1)
    }

    
    class func showPayWay(callBack:  @escaping (_ item: PayWayModel) -> Void) {
        currentView = PayWayView.init()
        currentView?.show()
        didSelectRowAt = callBack
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
            make.right.left.equalToSuperview()
            make.height.equalTo(kItemH*2)
            make.top.equalTo(topView.snp.bottom)
        }
        
        okButton.snp.makeConstraints { (make) -> Void in
            make.right.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-SafeAreaBottomHeight)
            make.height.equalTo(kItemH)
        }

    }
    
    func show() {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.white
        bgView.addSubview(self)
        let relaityH = CGFloat(itemInfos.count) * kItemH + kTopH + kItemH
        let height = relaityH > kMaxH ? kMaxH : relaityH;
        
        self.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: height)
        bgView.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: height+SafeAreaBottomHeight)
        
        cover = NBCovor.init(contentView: bgView)
    }
    
}

extension PayWayView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "")
        
        cell.textLabel?.text = itemInfos[indexPath.row].name;
        cell.detailTextLabel?.text = itemInfos[indexPath.row].detail;
        cell.imageView?.image = ImageNamed(itemInfos[indexPath.row].imgName);

        if (self.selectedIndexPath == indexPath) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath;
        tableView.reloadData()
    }
}

