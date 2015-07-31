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
    // You can use uuidgen in terminal to generater new one.
    private static let _UUID: NSUUID = NSUUID(UUIDString: "7FA08BC7-A55F-45FC-85C0-0BF26F899530")!
    
    /// Get the singleton UUID object.
    class func UUID() -> NSUUID {
        return _UUID
    }
    
    private init() {}
}