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
    open override var childViewControllerForStatusBarHidden: UIViewController?
    {
        return self.topViewController
    }
    
    open override var childViewControllerForStatusBarStyle: UIViewController?
    {
        return self.topViewController
    }
}
