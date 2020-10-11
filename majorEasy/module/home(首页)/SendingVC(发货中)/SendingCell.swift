//
//  SendingCell.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/9.
//

import UIKit

class SendingCell: UITableViewCell {

    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var lineNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var readNumLabel: UILabel!
    
    @IBOutlet weak var contactNumLabel: UILabel!
    
    
    var currentModel = MySuppliesInfo()
    
    var deleteColsure: ((_ model: MySuppliesInfo) -> ())?
    var shareColsure: ((_ model: MySuppliesInfo) -> ())?
    var assignColsure: ((_ model: MySuppliesInfo) -> ())?
    var editColsure: ((_ model: MySuppliesInfo) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellWithModel(_ model: MySuppliesInfo) {
        self.currentModel = model
        lineNameLabel.text = (model.loadPlaceShow ?? "") + " -> " + (model.unloadPlaceShow ?? "")
        timeLabel.text = model.timeAgo
        contentLabel.text = "整车：" + (model.mySupplyMsg ?? "")
        typeLabel.text = "规格：" + "长\(model.goodsLength)/" + "宽\(model.goodsWide)/"
            + "高\(model.goodsHeight)/" + "直径\(model.goodsDiameter)米"
        readNumLabel.text = "\(model.supplyViews)"
        contactNumLabel.text = "\(model.haveContacted)"
    }
    
    @IBAction func editAgain(_ sender: UIButton) {
        guard let colsure = self.editColsure else {return}
        colsure(self.currentModel)
    }
    
    @IBAction func deleteBtnPressed(_ sender: UIButton) {
        guard let colsure = self.deleteColsure else {return}
        colsure(self.currentModel)
    }
    
    @IBAction func shareBtnPressed(_ sender: UIButton) {
        guard let colsure = self.shareColsure else {return}
        colsure(self.currentModel)
    }
    
    @IBAction func assignBtnPressed(_ sender: UIButton) {
        guard let colsure = self.assignColsure else {return}
        colsure(self.currentModel)
    }
    
}
