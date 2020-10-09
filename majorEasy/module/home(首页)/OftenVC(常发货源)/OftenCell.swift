//
//  OftenCell.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/9.
//

import UIKit

class OftenCell: UITableViewCell {

    @IBOutlet weak var lineNameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var againBtn: UIButton!
    
    @IBOutlet weak var deleteBtn: UIButton!

    var currentModel = MySuppliesInfo()
    
    var deleteColsure: ((_ model: MySuppliesInfo) -> ())?
    var againColsure: ((_ model: MySuppliesInfo) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        againBtn.layer.cornerRadius = 5
        deleteBtn.layer.cornerRadius = 5
        deleteBtn.layer.borderWidth = 1
        deleteBtn.layer.borderColor = RGBHex(0xdddddd).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellWithModel(_ model: MySuppliesInfo) {
        self.currentModel = model
        lineNameLabel.text = (model.loadPlaceShow ?? "") + " -> " + (model.unloadPlaceShow ?? "")
        timeLabel.text = model.timeAgo
        contentLabel.text = model.mySupplyMsg

        
    }
    
    @IBAction func sendAgain(_ sender: UIButton) {
        guard let colsure = self.againColsure else {return}
        colsure(self.currentModel)
    }
    
    @IBAction func deleteBtnPressed(_ sender: UIButton) {
        guard let colsure = self.deleteColsure else {return}
        colsure(self.currentModel)
    }
    
    
}
