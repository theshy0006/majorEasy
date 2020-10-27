//
//  CarTypeViewModel.swift
//  yunyou
//
//  Created by wangyang on 2020/4/14.
//  Copyright © 2020 com.boc. All rights reserved.
//

import UIKit

class CarTypeViewModel: NSObject {

    var length = ""
    var height = ""
    var carType = ""
    var type = ""
    
    var heightArr:Array = ["不限","1.6","1.25","1.1","0.95","0.8","0.7","0.6","0.5",
                                "0.4"]
    var lengthArr:Array = ["不限","23","22","18","17.5","13.7","13","9.6","6.8",
                                "4.2"]
    var carArr:Array = ["平板车","高栏车","抽拉板","三线六桥",
                         "四线八桥","框架车","爬梯车","轴线车",
                         "冷藏","高低板","集装箱车","厢式挂车"]
    var typeArr:Array = ["整车","零担"]

}
