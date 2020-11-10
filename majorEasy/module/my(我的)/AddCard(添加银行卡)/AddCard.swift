//
//  AddCard.swift
//  majorEasy
//
//  Created by wangyang on 2020/11/10.
//

import UIKit

class AddCard: BaseVC {

    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var cardNoField: UITextField!
    
    @IBOutlet weak var phoneField: UITextField!
    
    @IBOutlet weak var bankButton: UIButton!
    
    @IBOutlet weak var typeButton: UIButton!

    let viewModel = AddCardViewModel()
    
    var type = 2
    var bankId = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "添加银行卡"
        NBLoadManager.showLoading()
        viewModel.getBanks { [weak self] in
            NBLoadManager.hidLoading()
            if( self?.viewModel.showItemArray.count != 0 ) {
                self?.bankButton.setTitle(self?.viewModel.showItemArray[0].title, for: .normal)
                self?.bankId = self?.viewModel.dataSource[0].id ?? 0
            }
            
        } failure: { (error) in
            NBLoadManager.hidLoading()
            NBHUDManager.toast(error.message)
        }
    }
    
    

    @IBAction func addCard(_ sender: UIButton) {
        
        if (nameField.text?.count == 0) {
            NBHUDManager.toast("请输入持卡人姓名")
            return
        }
        
        if (cardNoField.text?.count == 0) {
            NBHUDManager.toast("请输入银行卡号")
            return
        }
        
        if (phoneField.text?.count == 0) {
            NBHUDManager.toast("请输入手机号码")
            return
        }
        
        if (bankId == -1) {
            NBHUDManager.toast("请选择银行")
            return
        }
        
        NBLoadManager.showLoading()
        viewModel.bind(cardType: self.type, bankId: bankId, cardNumber: cardNoField.text ?? "", cardHolderName: nameField.text ?? "", phoneNumber: phoneField.text ?? "") { [weak self] model in
            NBLoadManager.hidLoading()
            self?.showSuccess(message: model.message ?? "")
        } failure: { (error) in
            NBLoadManager.hidLoading()
            NBHUDManager.toast(error.message)
        }

    }
    
    func showSuccess(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "确定", style: .default, handler:{ [weak self] _ in
            self?.popBack()
        })
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func selectBankPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        NBActionSheet.showActionSheet(title: "选择银行", itemInfos: self.viewModel.showItemArray, callBack: { [weak self] (row, item) -> () in
            print(row)
            print(item)
            self?.bankButton.setTitle(self?.viewModel.showItemArray[row].title, for: .normal)
            self?.bankId = self?.viewModel.dataSource[row].id ?? 0
        })
    }
    
    @IBAction func selectBankTypePressed(_ sender: UIButton) {
        
        let item1 = NBActionSheetItem()
        item1.title = "借记卡"
        
        let item2 = NBActionSheetItem()
        item2.title = "信用卡"
        
        
        self.view.endEditing(true)
        NBActionSheet.showActionSheet(title: "选择银行卡类型", itemInfos: [item1, item2], callBack: { [weak self] (row, item) -> () in
            print(row)
            print(item)
            if (row == 0) {
                self?.typeButton.setTitle("借记卡", for: .normal)
                self?.type = 2
            } else {
                self?.typeButton.setTitle("信用卡", for: .normal)
                self?.type = 1
            }

        })
    }
    
}
