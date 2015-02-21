//
//  UINavigationControllerExtension.swift
//  iBeacon Demo
//
//  Created by Darktt on 15/02/21.
//  Copyright (c) 2015 Darktt. All rights reserved.
//

import UIKit

extension UINavigationController
{
    public override func childViewControllerForStatusBarHidden() -> UIViewController?
    {
        return self.topViewController
    }
    
    public override func childViewControllerForStatusBarStyle() -> UIViewController?
    {
        return self.topViewController
    }
}