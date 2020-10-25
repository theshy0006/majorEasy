//
//  TopTenCell.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/25.
//

import UIKit

class TopTenCell: UITableViewCell {

    @IBOutlet weak var topView: UIImageView!
    
    @IBOutlet weak var headImageVie: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var numlabel: UILabel!
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var alertLabel: UILabel!
    
    func setCellWithModel(_ model: TopTenItem, type: Int) {
        if let url = model.headPortraitUrl {
            let url = URL(string: url)
            
            self.headImageVie.sd_setImage(with: url, placeholderImage: ImageNamed("编组"))
        } else {
            self.headImageVie.image = ImageNamed("编组")
        }
        
        self.nameLabel.text = model.userRealName
        
        if(type == 0) {
            self.numlabel.text = "\(model.inviteNums)"
            alertLabel.text = "邀请人数"
        } else if (type == 1) {
            self.numlabel.text = "\(model.sumIntegral)"
            alertLabel.text = "返利金额"
        } else {
            self.numlabel.text = "\(model.sumRecharge)"
            alertLabel.text = "充值金额"
        }
        
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
