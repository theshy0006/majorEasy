//
//  SourceCell.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/9.
//

import UIKit

class SourceCell: UITableViewCell {

    
    @IBOutlet weak var headImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var carNoLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var helpLabel: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var assignButton: UIButton!
    
    @IBOutlet weak var pushButton: UIButton!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBAction func call(_ sender: UIButton) {
    }
    
    func setCellWithModel(_ model: CarInfo) {
        nameLabel.text = model.ownerName
        let url = URL(string: model.headPortraitUrl ?? "")
        headImageView.sd_setImage(with: url, placeholderImage: ImageNamed("defaultHeader"))
        carNoLabel.text = " " + (model.licenseNum ?? "") + " "
        typeLabel.text = " \(model.vehicleLength)米/"  + "\(model.vehicleHeight)米/" + (model.vehicleType ?? "") + " "
        timeLabel.text = model.locationMsg
        contentLabel.text = model.regularRoutesMsg
        helpLabel.text = "已合作\(model.cooperationTimes)次 | " + (model.userEvaluateRate ?? "")
        addressLabel.text = model.locationAddress
        //0 未认证 1 已认证 2认证审核中...
        if(model.idReview == 0) {
            tagLabel.text = " 未认证 "
        } else if(model.idReview == 1) {
            tagLabel.text = " 已认证 "
        } else if(model.idReview == 2) {
            tagLabel.text = " 认证审核中 "
        } else {
            tagLabel.text = " 未认证 "
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headImageView.layer.cornerRadius = 4
        tagLabel.layer.cornerRadius = 4
        carNoLabel.layer.cornerRadius = 4
        typeLabel.layer.cornerRadius = 4
        addButton.layer.cornerRadius = 4
        assignButton.layer.cornerRadius = 4
        pushButton.layer.cornerRadius = 4
        
        assignButton.layer.borderWidth = 1
        assignButton.layer.borderColor = RGBHex(0x7792BB).cgColor
        
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = RGBHex(0xF6F6F6).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
