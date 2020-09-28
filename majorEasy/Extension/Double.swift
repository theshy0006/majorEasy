//
//  Double.swift
//  majorEasy
//
//  Created by dede wang on 2018/12/6.
//  Copyright © 2018 dede wang. All rights reserved.
//

import UIKit

extension Double {
    
    var scaleX: CGFloat {
        return CGFloat(self) * (ScreenWidth / 375.0)
    }
}
