//
//  Broadcaster.swift
//  iBeacon Demo (SwiftUI)
//
//  Created by Darktt on 20/08/22.
//  Copyright © 2020 Darktt. All rights reserved.
//

import Combine
import CoreLocation
import CoreBluetooth

public class Broadcaster: ObservableObject
{
    // MARK: - Properties -
    
    @Published
    public var state: CBManagerState = .unknown
    
    private lazy var manager: CBPeripheralManager = {
        
        CBPeripheralManager(delegate: self.delegate, queue: nil)
    }()
    
    private lazy var delegate: BroadcasterDelegate = {
        
        BroadcasterDelegate(parent: self)
    }()
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public init()
    {
        
        self.state = self.manager.state
    }
    
    func startBroadcast()
    {
        guard self.state == .poweredOn else {
            
            Delay(duration: 0.25, execute: self.startBroadcast)
            
            return
        }
        
        let beacon: CLBeaconRegion = BeaconRegion.shared
        let uuid: UUID = beacon.uuid
        let serviceUUIDs: Array<CBUUID> = [CBUUID(nsuuid: uuid)]
        
        // Why return type is NSMutableDictionary?
        var peripheralData = beacon.peripheralData(withMeasuredPower: nil) as? Dictionary<String, Any>
        peripheralData?[CBAdvertisementDataLocalNameKey] = "iBeacon Demo"
        peripheralData?[CBAdvertisementDataServiceUUIDsKey] = serviceUUIDs
        
        self.manager.startAdvertising(peripheralData)
    }
    
    func stopBroadcast()
    {
        self.manager.stopAdvertising()
    }
}

// MARK: - Delegate Methods -

fileprivate class BroadcasterDelegate: NSObject, CBPeripheralManagerDelegate
{
    // MARK: - Properties -
    
    weak var parent: Broadcaster?
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    init(parent: Broadcaster)
    {
        super.init()
        
        self.parent = parent
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager)
    {
        DTLog("Update state to: \(peripheral.state.rawValue)")
        
        self.parent?.state = peripheral.state
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?)
    {
        DTLog("Stat advertising with error: \(error?.localizedDescription ?? "no error")")
    }
}
