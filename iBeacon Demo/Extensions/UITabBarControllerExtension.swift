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
    open override var childViewControllerForStatusBarHidden: UIViewController?
    {
        return self.selectedViewController
    }
    
    open override var childViewControllerForStatusBarStyle: UIViewController?
    {
        return self.selectedViewController
    }
}
