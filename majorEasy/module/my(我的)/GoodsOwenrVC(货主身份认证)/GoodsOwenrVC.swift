//
//  GoodsOwenrVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/24.
//

import UIKit

class GoodsOwenrVC: BaseVC {

    @IBOutlet weak var userTextField: UITextField!
    
    @IBOutlet weak var idCardTextField: UITextField!
    
    let viewModel = GoodsOwenrViewModel()
    
    var frontImageUrl = ""
    var backImageUrl = ""
    var current = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "货主身份认证"
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var frontBtn: UIButton!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBAction func frontButton(_ sender: Any) {
        current = 1
        NBUtility.showChooseCameraView(self, nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        current = 2
        NBUtility.showChooseCameraView(self, nil)
    }
    
    @IBAction func commit(_ sender: UIButton) {
        
        if (userTextField.text?.count == 0) {
            NBHUDManager.toast("请输入姓名")
            return;
        }
        
        if (idCardTextField.text?.count == 0) {
            NBHUDManager.toast("请输入姓名")
            return;
        }
        
        if (frontImageUrl.count == 0) {
            NBHUDManager.toast("请上传身份证正面照片")
            return;
        }
        
        if (backImageUrl.count == 0) {
            NBHUDManager.toast("请上传身份证背面照片")
            return;
        }
        
        NBLoadManager.showLoading()
        //提交
        viewModel.subUser(userRealName: userTextField.text!,
                          idCardNumber: idCardTextField.text!,
                          idCardFrontImgKey: frontImageUrl,
                          idCardReverseImgKey: backImageUrl, success: {[weak self] model in
            NBHUDManager.toast(model.message ?? "")
            NBLoadManager.hidLoading()
            self?.popBack()
        }) { (error) in
            NBLoadManager.hidLoading()
            NBHUDManager.toast(error.message)
        }
        
        
        
    }
    
    func upload(_ image: UIImage) {
        NBLoadManager.showLoading()
        //提交
        
        if (self.current == 1) {
            viewModel.uploadFrontImage(image: image, success: {[weak self] model in
                self?.frontImageUrl = model.value.imgkey ?? ""
                NBLoadManager.hidLoading()
            }) { (error) in
                NBLoadManager.hidLoading()
                NBHUDManager.toast(error.message)
            }
        } else if  (self.current == 2) {
            //提交
            viewModel.uploadBackImage(image: image, success: {[weak self] model in
                self?.backImageUrl = model.value.imgkey ?? ""
                NBLoadManager.hidLoading()
            }) { (error) in
                NBLoadManager.hidLoading()
                NBHUDManager.toast(error.message)
            }
        }
        

        
        
        
        
        
    }
    
}

extension GoodsOwenrVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK:选中图片，保存图片或视频到系统相册
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImage: UIImage?
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
            picker.dismiss(animated: true, completion: nil)
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
            picker.dismiss(animated: true, completion: nil)
        }
        if(current == 1) {
            frontBtn.setBackgroundImage(selectedImage, for: .normal)
        } else if (current == 2) {
            backBtn.setBackgroundImage(selectedImage, for: .normal)
        }
        upload(selectedImage ?? UIImage())
    }


}
