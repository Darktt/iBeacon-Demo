//
//  Configuration.swift
//  iBeacon Demo
//
//  Created by EdenLi on 2015/2/13.
//  Copyright (c) 2015年 Darktt. All rights reserved.
//

import Foundation

class iBeaconConfiguration
{
    // You can use uuidgen in terminal to generater new one.
    private let UUIDString: String = "7FA08BC7-A55F-45FC-85C0-0BF26F899530"
    
    var UUID: NSUUID {
        get {
            var _UUID: NSUUID = NSUUID(UUIDString: self.UUIDString)!
            
            return _UUID
        }
    }
}

import UIKit

class CustomTabBarController : UITabBarController
{
    override func childViewControllerForStatusBarHidden() -> UIViewController? {
        return self.selectedViewController
    }
    
    override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return self.selectedViewController
    }
}