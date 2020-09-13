//
//  BeaconRegion.swift
//  iBeacon Demo (SwiftUI)
//
//  Created by Darktt on 20/08/22.
//  Copyright © 2020 Darktt. All rights reserved.
//

import CoreLocation

// You can use uuidgen in terminal to generater new one.
private let kBeaconUUID = UUID(uuidString: "7FA08BC7-A55F-45FC-85C0-0BF26F899530")!

private let kIdentifier: String = "tw.darktt.beaconDemo"

struct BeaconRegion {
    
    static var shared: CLBeaconRegion = {
        
        let major: CLBeaconMajorValue = CLBeaconMajorValue.random(in: 1 ... 100)
        let minor: CLBeaconMinorValue = CLBeaconMinorValue.random(in: 1 ... 2)
        
        let beacon = CLBeaconRegion(uuid: kBeaconUUID, major: major, minor: minor, identifier: kIdentifier)
        
        return beacon
    }()
    
    static var receiveRegion: CLBeaconRegion {
        
        if #available(iOS 13.0, macCatalyst 13.0, *) {
            
            return CLBeaconRegion(uuid: kBeaconUUID, identifier: kIdentifier)
        } else {
            
            return CLBeaconRegion(proximityUUID: kBeaconUUID, identifier: kIdentifier)
        }
    }
}

public extension CLBeaconIdentityConstraint
{
    convenience init(region: CLBeaconRegion)
    {
        let major: UInt16 = region.major?.uint16Value ?? 0
        let minor: UInt16 = region.minor?.uint16Value ?? 0
        
        self.init(uuid: region.uuid, major: major, minor: minor)
    }
}
