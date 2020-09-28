//
//  NBEdgeView.swift
//  majorEasy
//
//  Created by wangyang on 2020/9/27.
//

import UIKit
//@IBDesignable 
class NBEdgeView: UIView {

    override func draw(_ rect: CGRect) {
        self.buttomBorder(width: 0.5, borderColor: color_sperator)
        self.topBorder(width: 0.5, borderColor: color_sperator)
    }

}
