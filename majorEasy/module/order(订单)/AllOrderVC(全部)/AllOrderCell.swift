//
//  AllOrderCell.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/30.
//

import UIKit

class AllOrderCell: UITableViewCell {

    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var agreementButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var fromLabel: UILabel!
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var toLabel: UILabel!
    
    @IBOutlet weak var sortLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var earnestLabel: UILabel!
    
    @IBOutlet weak var assureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        agreementButton.layer.cornerRadius = 5
        okButton.layer.cornerRadius = 5
        cancelButton.layer.cornerRadius = 5
        sortLabel.layer.cornerRadius = 3
        weightLabel.layer.cornerRadius = 3
        headImageView.layer.cornerRadius = 22
        cancelButton.layer.borderColor = RGBHex(0xDDDDDD).cgColor
        cancelButton.layer.borderWidth = 1
        okButton.layer.borderColor = RGBHex(0x7792BB).cgColor
        okButton.layer.borderWidth = 1
        
    }
    
    func setCellWithModel(_ model: OrderItem) {
        let url = URL(string: model.vehicleOwnerHeadPortraitUrl ?? "")
        headImageView.sd_setImage(with: url, placeholderImage: ImageNamed("placeholder"))
        
        if (model.userRole == 1) {
            userLabel.text = model.consignorName
        } else {
            userLabel.text = model.vehicleOwnerName
        }

        fromLabel.text = model.loadPlace
        toLabel.text = model.unloadPlace
        if let goodsName = model.goodsName {
            sortLabel.text = " " + goodsName  + " "
        } else {
            sortLabel.text = ""
        }
        
        weightLabel.text = " \(model.goodsWeight_lower)"  + "-" + "\(model.goodsWeight_upper)" + "吨 "
        typeLabel.text = "货物规格 " + "长\(model.goodsLength)" + "/" + "宽\(model.goodsWide)" + "/" + "高\(model.goodsHeight)"
        earnestLabel.text = "定金：" + String(format:"%.2f",model.earnestMoney)
        assureLabel.text = "保证金：" + String(format:"%.2f",model.securityBond)
        
        
        
        let attrStr = NSMutableAttributedString.init(string: self.earnestLabel.text ?? "  ")
        attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value:RGBHex(0x666666), range:NSRange.init(location:0, length: 3))
        self.earnestLabel.attributedText = attrStr
        
        let attrStr2 = NSMutableAttributedString.init(string: self.assureLabel.text ?? "  ")
        attrStr2.addAttribute(NSAttributedString.Key.foregroundColor, value:RGBHex(0x666666), range:NSRange.init(location:0, length: 4))
        self.assureLabel.attributedText = attrStr2
        
        
        
    }
    
}
