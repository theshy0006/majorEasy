//
//  MyCardCell.swift
//  majorEasy
//
//  Created by wangyang on 2020/11/10.
//

import UIKit

class MyCardCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var cardNameLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var cardNoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.addShadow(RGBHex(0xe2e2e2))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellWithModel(_ model: CardItem) {

        if let url = model.logoUrlApp {
            let url = URL(string: url)
            self.iconView.sd_setImage(with: url, placeholderImage: ImageNamed("placeholder"))
        } else {
            self.iconView.image = ImageNamed("placeholder")
        }
        
        cardNameLabel.text = model.bankName
        
        typeLabel.text = model.typeName
        
        cardNoLabel.text = model.cardNumber
        
        bgView.backgroundColor = UIColor.colorWithHexString(hex: model.color ?? "#FFFFFF")
        
    }
    
}
