//
//  RechargeCell.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/28.
//

import UIKit

class RechargeCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func setCellWithModel(_ model: RechargeListItem) {

        nameLabel.text = model.rechargeTypeName
        statusLabel.text = model.rechargeStatus
        priceLabel.text = "+" + String(format: "%.2f", model.amount)
        timeLabel.text = NBUtility.formatUTCTime(model.rechargeTime ?? "") 
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
