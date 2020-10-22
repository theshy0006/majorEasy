//
//  PersonalVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/10/21.
//

import UIKit
import Alamofire

class PersonalVC: BaseVC {

    @IBOutlet weak var headImageView: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var headImageKey = "";
    
    var email = "";
    
    var userName = "";
    
    
    let viewModel = PersonalViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人资料"
        if let url = DataCenterManager.default.myInfo.headPortraitUrl {
            let url = URL(string: url)
            self.headImageView.sd_setImage(with: url, placeholderImage: ImageNamed("编组"))
        } else {
            self.headImageView.image = ImageNamed("编组")
        }
    }
    
    @IBAction func headBtnPressed(_ sender: UIButton) {
        NBUtility.showChooseCameraView(self, nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        
        email = emailTextField.text ?? ""
        userName = nameTextField.text ?? ""
        NBLoadManager.showLoading()
        if( email.count != 0 || userName.count != 0 || headImageKey.count != 0 ) {
            viewModel.save(headImage: headImageKey, userName: userName, email: email) { (model) in
                NBHUDManager.toast("保存成功")
                NBLoadManager.hidLoading()
            } failure: { (error) in
                NBLoadManager.hidLoading()
                NBHUDManager.toast(error.message)
            }

        }
        
        
    }
    
    
    
    func upload(_ image: UIImage) {
        NBLoadManager.showLoading()
        //提交
        viewModel.uploadHeadImage(image: image, success: {[weak self] model in
            self?.headImageKey = model.value.imgkey ?? ""
            NBLoadManager.hidLoading()
        }) { (error) in
            NBLoadManager.hidLoading()
            NBHUDManager.toast(error.message)
        }
        
    }
    

}

extension PersonalVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        headImageView.image = selectedImage;
        upload(selectedImage ?? UIImage())
    }


}




