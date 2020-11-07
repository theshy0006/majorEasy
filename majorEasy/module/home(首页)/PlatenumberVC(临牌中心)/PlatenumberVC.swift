//
//  PlatenumberVC.swift
//  majorEasy
//
//  Created by wangyang on 2020/11/6.
//

import UIKit

class PlatenumberVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "大件无忧临牌中心"
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func buttonOnePressed(_ sender: Any) {
        gotoMain()
    }
    
    @IBAction func buttonTwoPressed(_ sender: Any) {
        gotoMain()
    }
    
    @IBAction func buttonThreePressed(_ sender: Any) {
        gotoMain()
    }
    
    @IBAction func buttonFourPressed(_ sender: Any) {
        gotoMain()
    }
    
    func gotoMain() {
        PayWayView.showPayWay(callBack: { (item) -> () in
            print(item)
        })
    }
    
    

    
}
