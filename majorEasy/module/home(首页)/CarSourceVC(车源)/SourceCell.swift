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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
