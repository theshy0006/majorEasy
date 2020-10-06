//
//  SpecialLineCell.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/6.
//

import UIKit

class SpecialLineCell: UITableViewCell {
    
    var item = DedicatedLinesItem()
    
    @IBOutlet weak var statusBtn: UIButton!
    
    @IBOutlet weak var companyLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var companyImageView: UIImageView!
    
    @IBOutlet weak var fromLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var toLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var timesLabel: UILabel!
    
    @IBOutlet weak var phoneBtn: UIButton!
    
    @IBAction func callPhone(_ sender: UIButton) {
        
        if let telUrl = URL(string: "tel://\(item.contactMobile ?? "")") {
            UIApplication.shared.open(telUrl, options: [:], completionHandler: nil)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        statusBtn.layer.cornerRadius = 4
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellWithModel(_ model: DedicatedLinesItem) {
        item = model
        if( model.authentication ) {
            statusBtn.setTitle(" vip已认证 ", for: .normal)
        } else {
            statusBtn.setTitle(" vip未认证 ", for: .normal)
        }
        
        companyLabel.text = model.companyName
        let url = URL(string: model.logoPic ?? "")
        companyImageView.sd_setImage(with: url, placeholderImage: ImageNamed("placeholder"))
        fromLabel.text = model.companyAddress
        toLabel.text =  (model.loadPlace ?? "") + "->" + (model.unloadPlace ?? "")
        contentLabel.text = String(format:"%.2f",model.heavyUnitPrice) + "/吨 " + String(format:"%.2f",model.bubbleUnitPrice) + "/方"
        timeLabel.text = "运输时效："+"\(model.transportDays)"
        timesLabel.text = "\(model.views)"
        distanceLabel.text = "\(model.distance)公里"
    }
    
}
