//
//  Configuration.swift
//  iBeacon Demo
//
//  Created by Darktt on 15/02/13.
//  Copyright (c) 2015年 Darktt. All rights reserved.
//

import Foundation

class iBeaconConfiguration
{
    class func UUID() -> NSUUID
    {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: NSUUID? = nil
        }
        
        let dispatchBlock: (() -> Void) = {
            () -> Void in
            // You can use uuidgen in terminal to generater new one.
            let UUIDString: String = "7FA08BC7-A55F-45FC-85C0-0BF26F899530"
            
            Static.instance = NSUUID(UUIDString: UUIDString)
        }
        
        dispatch_once(&Static.onceToken, dispatchBlock)
        
        return Static.instance!
    }
}