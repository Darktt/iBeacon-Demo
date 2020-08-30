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
    // MARK: - Mac -
    
    static var mac: PreviewDevice {
        
        return "Mac"
    }
    
    // MARK: - iPhone -
    
    static var iPhoneSE: PreviewDevice {
        
        "iPhone SE"
    }
    
    static var iPhone7: PreviewDevice {
        
        PreviewDevice.iPhone8
    }
    
    static var iPhone7Plus: PreviewDevice {
        
        PreviewDevice.iPhone8Plus
    }
    
    static var iPhone8: PreviewDevice {
        
        "iPhone 8"
    }
    
    static var iPhone8Plus: PreviewDevice {
        
        "iPhone 8 Plus"
    }
    
    static var iPhoneX: PreviewDevice {
        
        "iPhone X"
    }
    
    static var iPhoneXS: PreviewDevice {
        
        PreviewDevice.iPhoneX
    }
    
    static var iPhone11Pro: PreviewDevice {
        
        PreviewDevice.iPhoneX
    }
    
    static var iPhoneXR: PreviewDevice {
        
        "iPhone XR"
    }
    
    static var iPhone11: PreviewDevice {
        
        PreviewDevice.iPhoneXR
    }
    
    static var iPhoneXSMax: PreviewDevice {
        
        "iPhone XS Max"
    }
    
    static var iPhone11ProMax: PreviewDevice {
        
        PreviewDevice.iPhoneXSMax
    }
    
    // MARK: - Apple Watch -
    
    /// Apple watch 38mm
    static var appleWatch38mm: PreviewDevice {
        
        "Apple Watch Series 2 - 38mm"
    }
    
    /// Apple watch 42mm
    static var appleWatch42mm: PreviewDevice {
        
        "Apple Watch Series 2 - 42mm"
    }
    
    /// Apple watch 40mm
    static var appleWatch40mm: PreviewDevice {
        
        "Apple Watch Series 4 - 40mm"
    }
    
    /// Apple watch 44mm
    static var appleWatch44mm: PreviewDevice {
        
        "Apple Watch Series 4 - 44mm"
    }
    
    // MARK: - iPad -
    
    /// iPad mini
    static var iPadMini: PreviewDevice {
        
        "iPad mini 4"
    }
    
    /// iPad Air
    static var iPadAir: PreviewDevice {
        
        "iPad Air 2"
    }
    
    /// iPad
    static var iPad: PreviewDevice {
        
        "iPad (5th generation)"
    }
    
    /// iPad Pro 9.7-inch
    static var iPadPro9_7: PreviewDevice {
        
        "iPad Pro (9.7-inch)"
    }
    
    /// iPad Pro 10.5-inch
    static var iPadPro10_5: PreviewDevice {
        
        "iPad Pro (10.5-inch)"
    }
    
    /// iPad Pro 11-inch
    static var iPadPro11: PreviewDevice {
        
        "iPad Pro (12.9-inch)"
    }
    
    /// iPad Pro 12.9-inch
    static var iPadPro12_9: PreviewDevice {
        
        "iPad Pro (12.9-inch)"
    }
    
    // MARK: - Apple TV -
    
    /// Apple TV
    static var tv: PreviewDevice {
        
        "Apple TV"
    }
    
    /// Apple TV 4K
    static var tv4K: PreviewDevice {
        
        "Apple TV 4K"
    }
    
    /// Apple TV 4K (at 1080p)
    static var tvAt1080P: PreviewDevice {
        
        "Apple TV 4K (at 1080p)"
    }
}
