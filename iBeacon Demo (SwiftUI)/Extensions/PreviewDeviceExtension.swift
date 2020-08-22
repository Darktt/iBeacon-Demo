//
//  PreviewDeviceExtension.swift
//
//  Created by Darkt on 19/12/17.
//  Copyright © 2019 Darktt. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public extension PreviewDevice
{
    static var iPhoneSE: PreviewDevice {
        
        PreviewDevice.init(rawValue: "iPhone SE")
    }
    
    static var iPhone7: PreviewDevice {
        
        PreviewDevice.iPhone8
    }
    
    static var iPhone7Plus: PreviewDevice {
        
        PreviewDevice.iPhone8Plus
    }
    
    static var iPhone8: PreviewDevice {
        
        PreviewDevice.init(rawValue: "iPhone 8")
    }
    
    static var iPhone8Plus: PreviewDevice {
        
        PreviewDevice.init(rawValue: "iPhone 8 Plus")
    }
    
    static var iPhoneX: PreviewDevice {
        
        PreviewDevice.init(rawValue: "iPhone X")
    }
    
    static var iPhoneXS: PreviewDevice {
        
        PreviewDevice.iPhoneX
    }
    
    static var iPhone11Pro: PreviewDevice {
        
        PreviewDevice.iPhoneX
    }
    
    static var iPhoneXR: PreviewDevice {
        
        PreviewDevice.init(rawValue: "iPhone XR")
    }
    
    static var iPhone11: PreviewDevice {
        
        PreviewDevice.iPhoneXR
    }
    
    static var iPhoneXSMax: PreviewDevice {
        
        PreviewDevice.init(rawValue: "iPhone XS Max")
    }
    
    static var iPhone11ProMax: PreviewDevice {
        
        PreviewDevice.iPhoneXSMax
    }
}
