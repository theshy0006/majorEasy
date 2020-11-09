//
//  QuoteCell.swift
//  majorEasy
//
//  Created by wangyang on 2020/11/9.
//

import UIKit

class QuoteCell: UITableViewCell {

    @IBOutlet weak var fromCity: UILabel!
    
    @IBOutlet weak var toCity: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var currentModel = QuoteItem()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellWithModel(_ model: QuoteItem) {
        
        currentModel = model
        fromCity.text = model.loadPlaceShow?.replacingOccurrences(of: "/", with: "")
        toCity.text = model.unloadPlaceShow?.replacingOccurrences(of: "/", with: "")
        contentLabel.text = model.mySupplyMsg
        detailLabel.text = model.offerMsg
        timeLabel.text = NBUtility.formatUTCTime(model.offerTime ?? "")
    }
}
