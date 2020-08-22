//
//  BeaconRegion.swift
//  iBeacon Demo (SwiftUI)
//
//  Created by Darktt on 20/08/22.
//  Copyright © 2020 Darktt. All rights reserved.
//

import CoreLocation

private let kBeaconUUID = UUID(uuidString: "")!

struct BeaconRegion {
    
    static var shared: CLBeaconRegion = {
        
        let major: CLBeaconMajorValue = CLBeaconMajorValue.random(in: 1 ... 100)
        let minor: CLBeaconMinorValue = CLBeaconMinorValue.random(in: 1 ... 2)
        
        let beacon = CLBeaconRegion(uuid: kBeaconUUID, major: major, minor: minor, identifier: "tw.darktt.beaconDemo")
        
        return beacon
    }()
}
