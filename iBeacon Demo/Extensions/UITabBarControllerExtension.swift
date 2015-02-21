//
//  UITabBarControllerExtension.swift
//  iBeacon Demo
//
//  Created by Darktt on 15/02/21.
//  Copyright (c) 2015 Darktt. All rights reserved.
//

import UIKit

extension UITabBarController
{
    public override func childViewControllerForStatusBarHidden() -> UIViewController?
    {
        return self.selectedViewController
    }
    
    public override func childViewControllerForStatusBarStyle() -> UIViewController?
    {
        return self.selectedViewController
    }
}