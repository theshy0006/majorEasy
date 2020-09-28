//
//  LayoutProtocol.swift
//  NoteBook
//
//  Created by dede wang on 2019/10/19.
//  Copyright © 2019 com.boc. All rights reserved.
//
import UIKit

protocol NB_ControllerLayoutElements where Self: UIViewController {
    var isLayouted: Bool {get set}
    func controllerShouldLayout() -> Bool
    func controllerDidLayout(_ isLayout: inout Bool)
    func controllerNeedRelayout(_ isNeed: inout Bool)
}

extension NB_ControllerLayoutElements where Self: UIViewController{
    func controllerShouldLayout() -> Bool {
        return !self.isLayouted
    }
    
    func controllerDidLayout(_ isLayout: inout Bool) {
        if isLayout {
            print("the controller alread layouted")
        } else {
            isLayout = true
        }
    }
    
    func controllerNeedRelayout(_ isNeedRelayout: inout Bool) {
        if isNeedRelayout {
            isNeedRelayout = false
        } else {
            print("no need call this method")
        }
    }
}

protocol NB_ControllerLayoutProtocol {
    associatedtype LayoutTarget
    func doControllerLayout(_ parent: LayoutTarget)
}

protocol NB_ViewLayoutElements where Self: UIView {
    var isLayouted: Bool {get set}
    func viewShouldLayout() -> Bool
    func viewDidLayout(_ isLayout: inout Bool)
    func viewNeedRelayout(_ isNeed: inout Bool)
}

extension NB_ViewLayoutElements where Self: UIView {
    func viewShouldLayout() -> Bool {
        return !self.isLayouted
    }
    
    func viewDidLayout(_ isLayout: inout Bool) {
        if isLayout {
           print("the view alread layouted")
        } else {
            isLayout = true
        }
    }
    
    func viewNeedRelayout(_ isNeedRelayout: inout Bool) {
        if isNeedRelayout {
            isNeedRelayout = false
        } else {
            print("no need call this method")
        }
    }
}

protocol NB_ViewLayoutProtocol {
    associatedtype LayoutTarget
    func doViewLayout(_ parent: LayoutTarget)
}
