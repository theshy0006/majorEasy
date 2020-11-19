//
//  InviteCell.swift
//  majorEasy
//
//  Created by wangyang on 2020/11/19.
//

import UIKit

class InviteCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var jobLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellWithModel(_ model: RecruitListItem) {
        nameLabel.text = model.title
        jobLabel.text = model.job
        timeLabel.text = NBUtility.formatUTCTime(model.releaseTime ?? "")
        addressLabel.text = model.workArea
        priceLabel.text = model.salary
    }
    
    func setCellWithModel(_ model: DriverItem) {
        nameLabel.text = model.title
        jobLabel.text = model.job
        timeLabel.text = NBUtility.formatUTCTime(model.releaseTime ?? "")
        addressLabel.text = model.workArea
        priceLabel.text = model.salary
    }
    
    
}
