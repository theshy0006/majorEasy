//
//  BillCell.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/27.
//

import UIKit

class BillCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    func setCellWithModel(_ model: BillItem) {
        typeLabel.text = model.operation
        if (model.operation == "定金转入") {
            nameLabel.text = "汇款人:" + (model.userName ?? "")
        } else if (model.operation == "定金退还" || model.operation == "定金支付") {
            nameLabel.text = "支付对象:" + (model.userName ?? "")
        } else {
            nameLabel.text = model.userName
        }
        addressLabel.text = model.placeInfo
        
        if( model.type == 2 ) {
            priceLabel.text = "+" + String(format: "%.2f", model.amount)
        } else {
            priceLabel.text = "-" + String(format: "%.2f", model.amount)
        }
        
        timeLabel.text = model.creatTime
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
