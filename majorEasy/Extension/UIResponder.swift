//
//  UIResponder.swift
//  majorEasy
//
//  Created by dede on 2019/3/7.
//  Copyright © 2019 dede. All rights reserved.
//

import UIKit
import RxSwift

private var AssociatedObjectHandle: UInt8 = 0

public extension UIResponder {
    var disposeBag:DisposeBag {
        get {
            let _dispose = objc_getAssociatedObject(self, &AssociatedObjectHandle)
            if _dispose == nil {
                self.disposeBag = DisposeBag()
            }
            return  objc_getAssociatedObject(self, &AssociatedObjectHandle) as! DisposeBag
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
