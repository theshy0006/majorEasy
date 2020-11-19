//
//  ShopCell.swift
//  majorEasy
//
//  Created by wangyang on 2020/11/19.
//

import UIKit

class ShopCell: UITableViewCell {

    @IBOutlet weak var tagImageView: UIImageView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var tagLabel1: UILabel!
    
    @IBOutlet weak var tagLabel2: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellWithModel(_ model: GoodsItem) {
        contentLabel.text = model.title
        tagLabel1.text = model.size ?? "" + "英寸"
        tagLabel2.text = model.material
        priceLabel.text = "￥" + (model.price ?? "")
        statusLabel.text = "0人购买"
    }
    
}
