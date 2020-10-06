//
//  CarTypeViewModel.swift
//  yunyou
//
//  Created by wangyang on 2020/4/14.
//  Copyright © 2020 com.boc. All rights reserved.
//

import UIKit

class CarTypeViewModel: NSObject {

    var selectLength = ["", "", ""]
    var length1 = ""
    var length2 = ""
    var length3 = ""
    var selectType = ["", "", ""]
    var type1 = ""
    var type2 = ""
    var type3 = ""
    
    var lengthArr:Array = ["1.8","2.7","3.8","4.2","5.0","6.2","6.8","7.7",
                                "8.2","8.7","9.6","11.7","12.5","13.0","13.7","15.0",
                                "16.0","17.5"]
    var typeArr:Array = ["平板","高栏","箱式","集装箱",
                         "自卸","冷藏","保温","高低板",
                         "面包车","棉被车","爬梯车","飞翼车"]

}
