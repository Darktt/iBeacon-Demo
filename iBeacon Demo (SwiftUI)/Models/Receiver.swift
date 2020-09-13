//
//  Receiver.swift
//  iBeacon Demo
//
//  Created by Darktt on 20/09/03.
//  Copyright © 2020 Darktt. All rights reserved.
//

import Foundation
import CoreLocation
import CoreBluetooth

public class Receiver: ObservableObject
{
    // MARK: - Properties -
    
    @Published
    public var beacons: [CLBeacon] = []
    
    @Published
    public var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    private let locationManager: CLLocationManager = .init()
    
    private lazy var delegate: ReceiverDelegate = {
        
        ReceiverDelegate(parent: self)
    }()
    
    fileprivate var isStartMonitoring: Bool = false
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public init()
    {
        self.authorizationStatus = CLLocationManager.authorizationStatus()
        self.locationManager.delegate = self.delegate
    }
    
    func startReceiving()
    {
        self.isStartMonitoring = true
        
        if self.authorizationStatus == .notDetermined {
            
            self.locationManager.requestWhenInUseAuthorization()
            return
        }
        
        let beaconRegion: CLBeaconRegion = BeaconRegion.receiveRegion
        
        self.locationManager.startMonitoring(for: beaconRegion)
    }
    
    func stopReceiving()
    {
        let beaconRegion: CLBeaconRegion = BeaconRegion.receiveRegion
        
        self.isStartMonitoring = false
        self.locationManager.stopMonitoring(for: beaconRegion)
    }
    
    func cleanup() {
        
        self.beacons.removeAll()
    }
}

fileprivate class ReceiverDelegate: NSObject, CLLocationManagerDelegate
{
    // MARK: - Properties -
    
    weak var parent: Receiver?
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    init(parent: Receiver)
    {
        super.init()
        
        self.parent = parent
    }
    
    // MARK: - Delegete Methods -
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        DTLog("Change authorization: \(status)")
        
        self.parent?.authorizationStatus = status
        
        guard status == .authorizedWhenInUse && self.parent?.isStartMonitoring == true else {
            
            return
        }
        
        self.parent?.startReceiving()
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion)
    {
        DTLog("Did start monitoring...")
        
        manager.requestState(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error)
    {
        DTLog("Monitoring fail with error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion)
    {
        guard let beaconRegion = region as? CLBeaconRegion else {
            
            return
        }
        
        DTLog("Did determine state: \(state), region: \(beaconRegion)")
        
        let identityConstraint = CLBeaconIdentityConstraint(region: beaconRegion)
        
        if state == .inside {
            manager.startRangingBeacons(satisfying: identityConstraint)
            return
        }
        
        manager.stopRangingBeacons(satisfying: identityConstraint)
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint)
    {
        DTLog("Did rang beacons with count: \(beacons.count)")
        
        self.parent?.beacons += beacons
    }
}
