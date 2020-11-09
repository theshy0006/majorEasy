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
        
        let str1 = (model.loadPlaceShow ?? "") + " -> " + (model.unloadPlaceShow ?? "")
        lineNameLabel.text = str1.replacingOccurrences(of: "/", with: "")
        
        lengthLabel.text =  String(format:" %.1f米 ",model.vehicleLength ?? 0)
        tagLabel.text = model.vehicleType
        weightLabel.text = model.goodsWeight! + "吨"
        timeLabel.text = model.timeAgo
        
        var loadType = "一装一卸"
        if(model.loadMode == 1) {
            loadType = "一装一卸"
        } else if(model.loadMode == 2) {
            loadType = "一装两卸"
        } else if(model.loadMode == 3) {
            loadType = "一装多卸"
        } else if(model.loadMode == 4) {
            loadType = "两装一卸"
        } else if(model.loadMode == 5) {
            loadType = "两装两卸"
        } else if(model.loadMode == 6) {
            loadType = "多装多卸"
        }
        
        let type = model.goodsName! + "/" + model.useMode! + "/" + loadType
        typeLabel.text = type
        sizeLabel.text = String(format:"货物尺寸 长%.1f米 ",model.goodsLength) + String(format:"宽%.1f米 ",model.goodsWide) + String(format:"高%.1f米",model.goodsHeight)
        if let url = model.headPortraitUrl {
            let url = URL(string: url)
            self.headImageView.sd_setImage(with: url, placeholderImage: ImageNamed("defaultHeader"))
        } else {
            self.headImageView.image = ImageNamed("defaultHeader")
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
