//
//  AllGoodsCell.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/12.
//

import UIKit

class AllGoodsCell: UITableViewCell {

    @IBOutlet weak var lineNameLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timesLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var readLabel: UILabel!

    var currentModel = MySuppliesInfo()
    
    @IBAction func call(_ sender: UIButton) {
        NBUtility.showTelephone(self.currentModel.phoneNumber ?? "")
    }
    
    func setCellWithModel(_ model: MySuppliesInfo) {
        self.currentModel = model
        
        lineNameLabel.text = (model.loadPlaceShow ?? "") + " -> " + (model.unloadPlaceShow ?? "")
        lengthLabel.text =  String(format:" %.1f米 ",model.vehicleLength ?? 0)
        tagLabel.text = model.vehicleType
        weightLabel.text = model.goodsWeight! + "吨"
        timeLabel.text = model.timeAgo
        let type = model.goodsName! + "/" + model.useMode! + "/" + model.loadMode!
        typeLabel.text = type
        sizeLabel.text = String(format:"货物尺寸 长%.1f米 ",model.goodsLength) + String(format:"宽%.1f米 ",model.goodsWide) + String(format:"高%.1f米",model.goodsHeight)
        if let url = model.headPortraitUrl {
            let url = URL(string: url)
            self.headImageView.sd_setImage(with: url, placeholderImage: ImageNamed("编组"))
        } else {
            self.headImageView.image = ImageNamed("编组")
        }
        nameLabel.text = model.userRealName
        timesLabel.text = "交易 \(model.releaseNum) 次"
        if (model.purposePrice < 0.01) {
            priceLabel.text = "暂无估价"
        } else {
            priceLabel.text = "系统估计：\(model.purposePrice) 元"
        }
        
        readLabel.text = "浏览量" + "\(model.supplyViews)"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lengthLabel.layer.cornerRadius = 5
        tagLabel.layer.cornerRadius = 5
        weightLabel.layer.cornerRadius = 5
        headImageView.layer.cornerRadius = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
