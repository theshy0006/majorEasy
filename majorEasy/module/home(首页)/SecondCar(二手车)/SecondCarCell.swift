//
//  SecondCarCell.swift
//  majorEasy
//
//  Created by wangyang on 2020/11/19.
//

import UIKit

class SecondCarCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var addresslabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var tagImageView: UIImageView!
    
    func setCellWithModel(_ model: UsedVehiclesItem) {
        if (model.type == 1 || model.type == 0) {
            titleLabel.text = (model.headBrandName ?? "") + " \(model.head_horsepower) " +  (model.standardName ?? "") + "牵引头"
            contentLabel.text = (model.flatbedBrandName ?? "") + " \(model.flatbed_length) " + (model.flatbedTypeName ?? "") + "板车"
        } else if (model.type == 2) {
            titleLabel.text = (model.headBrandName ?? "") + " \(model.head_horsepower) " +  (model.standardName ?? "") + "牵引头"
            contentLabel.text = ""
        } else if (model.type == 3) {
            titleLabel.text = (model.flatbedBrandName ?? "") + " \(model.flatbed_length) " + (model.flatbedTypeName ?? "") + "板车"
            contentLabel.text = ""
        }
        
        addresslabel.text = model.location
        timeLabel.text = NBUtility.formatUTCTime(model.releaseTime ?? "")
        
        if (model.pictureUrl?.count != 0) {
            if let url = model.pictureUrl?[0] {
                let url = URL(string: url)
                tagImageView.sd_setImage(with: url, placeholderImage: ImageNamed("placeholder"))
            } else {
                tagImageView.image = ImageNamed("placeholder")
            }
        } else {
            tagImageView.image = ImageNamed("placeholder")
        }
        
    }
}
