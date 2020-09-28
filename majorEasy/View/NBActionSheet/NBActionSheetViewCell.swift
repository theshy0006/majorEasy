//
//  NBActionSheetViewCell.swift
//  acorn
//
//  Created by dede on 2019/3/14.
//  Copyright © 2019 dede. All rights reserved.
//

import UIKit
import SnapKit

struct NBActionSheetViewCellLayoutParameters {
    let iconView_Left: CGFloat = 12.0.scaleX
    let iconView_height: CGFloat = 24
    let titleLabel_Left: CGFloat = 46.0.scaleX
    let titleLabel_Right: CGFloat = -12.0.scaleX
}

class NBActionSheetViewCell: UITableViewCell {

    var item: NBActionSheetItem?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
        doViewLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initView() {
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        
        self.contentView.addSubview(iconView)
        self.contentView.addSubview(tagIconView)
        self.contentView.addSubview(titleLabel)
    }
    
    func doViewLayout() {
        let parma = NBActionSheetViewCellLayoutParameters()

        iconView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(parma.iconView_Left)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(parma.iconView_height)
        }

        tagIconView.snp.makeConstraints { (make) -> Void in
            make.right.bottom.equalTo(iconView)
        }

        titleLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(parma.titleLabel_Left)
            make.right.equalToSuperview().offset(parma.titleLabel_Right)
            make.height.equalTo(parma.iconView_height)
            make.centerY.equalToSuperview()
        }
    }

    func setCellContent(item: NBActionSheetItem) {
        //
        if let image = item.image {
            self.iconView.image = image
            self.iconView.isHidden = false
        } else if let imgName = item.imageName {
            self.iconView.image = UIImage(named: imgName)
            self.iconView.isHidden = false
        } else {
            self.iconView.isHidden = true
        }
        let parma = NBActionSheetViewCellLayoutParameters()
        if self.iconView.isHidden {
            titleLabel.snp.updateConstraints { (make) -> Void in
                make.left.equalToSuperview().offset(parma.iconView_Left)
            }
        } else {
            titleLabel.snp.updateConstraints { (make) -> Void in
                make.left.equalToSuperview().offset(parma.titleLabel_Left)
            }
        }
        
        if let tagImgName = item.tagImgName {
            self.tagIconView.image = UIImage(named: tagImgName)
        }

        if self.isPurnInt(string: item.title) {
            self.titleLabel.font = PingFangRegular(14.0)
            self.titleLabel.text = item.title;
        } else {
            self.titleLabel.font = PingFangRegular(14.0)
            self.titleLabel.text = item.title
        }
        
        
    }
    
    lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var tagIconView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = RGBHex(0x666666)
        label.font = PingFangRegular(14.0)
        return label
    }()
    
    // 判断输入的字符串是否为数字，不含其它字符
    func isPurnInt(string: String) -> Bool {
        let scan: Scanner = Scanner(string: string)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
    }
    

}
