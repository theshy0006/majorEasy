//
//  GoodStandardVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/27.
//

import UIKit

class GoodStandardVC: BaseVC {

    var myColsure: ((_ length: String, _ width: String, _ height: String, _ diameter: String, _ remark: String) -> ())?
    
    @IBOutlet weak var lengthField: UITextField!
    
    @IBOutlet weak var widthField: UITextField!
    
    @IBOutlet weak var heightField: UITextField!
    
    @IBOutlet weak var diameterField: UITextField!
    
    @IBOutlet weak var remarkTextView: UITextView!
    
    
    @IBOutlet weak var centerView: UIView!
    
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        self.popBack()
    }
    
    @IBAction func okButtonPressed(_ sender: UIButton) {
        
        guard let colsure = self.myColsure else {return}
        
        if (lengthField.text?.count == 0) {
            NBHUDManager.toast("请输入货长")
            return;
        }
        if (widthField.text?.count == 0) {
            NBHUDManager.toast("请输入货宽")
            return;
        }
        if (heightField.text?.count == 0) {
            NBHUDManager.toast("请输入货高")
            return;
        }
        if (diameterField.text?.count == 0) {
            NBHUDManager.toast("请输入直径")
            return;
        }
        
        colsure((self.lengthField.text ?? ""),(self.widthField.text ??   ""),(self.heightField.text ?? ""),(self.diameterField.text ?? ""), (self.remarkTextView.text ?? ""))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let itemWidth = (centerView.width - 75) / 5
        
        self.lengthField.frame = CGRect.init(x: 15, y: 47, width: itemWidth, height: 34)
        self.widthField.frame = CGRect.init(x: 30 + itemWidth, y: 47, width: itemWidth, height: 34)
        self.heightField.frame = CGRect.init(x: 45 + (itemWidth * 2), y: 47, width: itemWidth, height: 34)
        self.diameterField.frame = CGRect.init(x: 60 + (itemWidth * 3), y: 47, width: itemWidth, height: 34)
        
        
        self.centerView.layer.borderWidth = 3;
        self.centerView.layer.borderColor = tabbarFontSelectColor.cgColor
    }


}
