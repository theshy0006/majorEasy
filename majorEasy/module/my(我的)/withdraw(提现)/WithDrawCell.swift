//
//  WithDrawCell.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/28.
//

import UIKit

class WithDrawCell: UITableViewCell {

    
    @IBOutlet weak var cardNoLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCellWithModel(_ model: WithDrawItem) {

        cardNoLabel.text = model.cardNumber
        statusLabel.text = model.stateName
        priceLabel.text = "-" + String(format: "%.2f", model.amount)
        timeLabel.text = NBUtility.formatUTCTime(model.withdrawalTime ?? "")
        typeLabel.text = model.withdrawalTypeName
    }
    
}
