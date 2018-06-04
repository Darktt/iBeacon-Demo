//
//  BroadcastViewController.swift
//  iBeacon Demo
//
//  Created by Darktt on 15/01/31.
//  Copyright (c) 2015年 Darktt. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class BroadcastViewController: UIViewController
{
    fileprivate var broadcasting: Bool = false
    
    fileprivate var beacon: CLBeaconRegion?
    fileprivate var peripheralManager: CBPeripheralManager?
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var triggerButton: UIButton!
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.iOS7WhiteColor()
        
        let UUID: UUID = iBeaconConfiguration.uuid
        
        let major: CLBeaconMajorValue = CLBeaconMajorValue(arc4random() % 100 + 1)
        let minor: CLBeaconMinorValue = CLBeaconMinorValue(arc4random() % 2 + 1)
        
        self.beacon = CLBeaconRegion(proximityUUID: UUID, major: major, minor: minor, identifier: "tw.darktt.beaconDemo")
        
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    deinit
    {
        self.beacon = nil
        self.peripheralManager = nil
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
 
// MARK: - Status Bar -

extension BroadcastViewController
{
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        if self.broadcasting {
            return .lightContent
        }
        
        return .default
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation
    {
        return .fade
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return false
    }
}
    
//MARK: - Actions -

extension BroadcastViewController
{
    @IBAction fileprivate func broadcastBeacon(sender: UIButton) -> Void
    {
        let state: CBManagerState = self.peripheralManager!.state
        
        if (state == .poweredOff && !self.broadcasting) {
            let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            let alert: UIAlertController = UIAlertController(title: "Bluetooth OFF", message: "Please power on your Bluetooth!", preferredStyle: .alert)
            alert.addAction(OKAction)
            
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        let titleFromStatus: () -> String = {
            let title: String = (self.broadcasting) ? "Start" : "Stop"
            
            return title + " Broadcast"
        }
        
        let buttonTitleColor: UIColor = (self.broadcasting) ? UIColor.iOS7BlueColor() : UIColor.iOS7WhiteColor()
        
        sender.setTitle(titleFromStatus(), for: UIControlState.normal)
        sender.setTitleColor(buttonTitleColor, for: UIControlState.normal)
        
        let labelTextFromStatus: () -> String = {
            let text: String = (self.broadcasting) ? "Not Broadcast" : "Broadcasting..."
            
            return text
        }
        
        self.statusLabel.text = labelTextFromStatus()
        
        let animations: () -> Void = {
            let backgroundColor: UIColor = (self.broadcasting) ? UIColor.iOS7WhiteColor() : UIColor.iOS7BlueColor()
            
            self.view.backgroundColor = backgroundColor
            
            self.broadcasting = !self.broadcasting
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
        let completion: (Bool) -> Void = {
            finish in
            self.advertising(start: self.broadcasting)
        }
        
        UIView.animate(withDuration: 0.25, animations: animations, completion: completion)
    }
    
    // MARK: - Broadcast Beacon
    
    func advertising(start: Bool) -> Void
    {
        if self.peripheralManager == nil {
            return
        }
        
        if (!start) {
            self.peripheralManager!.stopAdvertising()
            
            return
        }
        
        let state: CBManagerState = self.peripheralManager!.state
        
        if (state == .poweredOn) {
            let UUID:UUID = (self.beacon?.proximityUUID)!
            let serviceUUIDs: Array<CBUUID> = [CBUUID(nsuuid: UUID)]
            
            // Why NSMutableDictionary can not convert to Dictionary<String, Any> 😂
            var peripheralData: Dictionary<String, Any> = self.beacon!.peripheralData(withMeasuredPower: 1)  as NSDictionary as! Dictionary<String, Any>
            peripheralData[CBAdvertisementDataLocalNameKey] = "iBeacon Demo" 
            peripheralData[CBAdvertisementDataServiceUUIDsKey] = serviceUUIDs
            
            self.peripheralManager!.startAdvertising(peripheralData)
        }
    }
}

// MARK: - CBPeripheralManager Delegate -

extension BroadcastViewController: CBPeripheralManagerDelegate
{
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager)
    {
        let state: CBManagerState = peripheralManager!.state
        
        if state == .poweredOff {
            self.statusLabel.text = "Bluetooth Off"
            
            if self.broadcasting {
                self.broadcastBeacon(sender: self.triggerButton)
            }
        }
        
        if state == .unsupported {
            self.statusLabel.text = "Unsupported Beacon"
        }
        
        if state == .poweredOn {
            self.statusLabel.text = "Not Broadcast"
        }
    }
}
