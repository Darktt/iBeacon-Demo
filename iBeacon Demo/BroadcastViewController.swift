//
//  BroadcastViewController.swift
//  iBeacon Tester
//
//  Created by EdenLi on 2015/1/31.
//  Copyright (c) 2015年 Darktt. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class BroadcastViewController: UIViewController, CBPeripheralManagerDelegate
{
    private var broadcasting: Bool = false
    
    private var beacon: CLBeaconRegion?
    private var peripheralManager: CBPeripheralManager?
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var triggerButton: UIButton!
    
    override func viewDidLoad()
    {
        self.view.backgroundColor = UIColor.iOS7WhiteColor()
        
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        // You can use uuidgen in terminal to generater new one.
        let UUID: NSUUID = NSUUID(UUIDString: "7FA08BC7-A55F-45FC-85C0-0BF26F899530")!
        
        let major: CLBeaconMajorValue = CLBeaconMajorValue(arc4random() % 100 + 1)
        let minor: CLBeaconMinorValue = CLBeaconMinorValue(arc4random() % 2 + 1)
        
        self.beacon = CLBeaconRegion(proximityUUID: UUID, major: major, minor: minor, identifier: "tw.darktt.beaconDemo")
        
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        
//        let status: CBPeripheralManagerAuthorizationStatus = CBPeripheralManager.authorizationStatus()
    }
    
    deinit
    {
        self.beacon = nil
        self.peripheralManager = nil
    }
    
    @IBAction func broadcastBeacon(sender: UIButton) -> Void
    {
        let state: CBPeripheralManagerState = self.peripheralManager!.state
        
        if (state == .PoweredOff && !self.broadcasting) {
            let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            
            let alert: UIAlertController = UIAlertController(title: "Bluetooth OFF", message: "Please power on your Bluetooth!", preferredStyle: .Alert)
            alert.addAction(OKAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
        }
        
        let titleFromStatus: (Void) -> String = {
            let title: String = (self.broadcasting) ? "Start" : "Stop"
            
            return title+" Broadcast"
        }
        
        let buttonTitleColor: UIColor = (self.broadcasting) ? UIColor.iOS7BlueColor() : UIColor.iOS7WhiteColor()
        
        sender.setTitle(titleFromStatus(), forState: .Normal)
        sender.setTitleColor(buttonTitleColor, forState: .Normal)
        
        let labelTextFromStatus: (Void) -> String = {
            let text: String = (self.broadcasting) ? "Not Broadcast" : "Broadcasting..."
            
            return text
        }
        
        self.statusLabel.text = labelTextFromStatus()
        
        let animations: () -> Void = {
            let backgroundColor: UIColor = (self.broadcasting) ? UIColor.iOS7WhiteColor() : UIColor.iOS7BlueColor()
            
            self.view.backgroundColor = backgroundColor
        }
        
        UIView.animateWithDuration(0.25, animations: animations)
        
        self.broadcasting = !self.broadcasting
        self.advertising(self.broadcasting)
    }
    
    // MARK: Broadcast Beacon
    func advertising(start: Bool) -> Void
    {
        if self.peripheralManager == nil {
            return;
        }
        
        if (!start) {
            self.peripheralManager!.stopAdvertising()
            
            return;
        }
        
        let state: CBPeripheralManagerState = self.peripheralManager!.state
        
        if (state == .PoweredOn) {
            let UUID:NSUUID! = self.beacon?.proximityUUID
            let serviceUUIDs: [CBUUID] = [CBUUID(NSUUID: UUID)]
            let beaconData: NSDictionary! = self.beacon?.peripheralDataWithMeasuredPower(nil)
            
            let peripheralData: NSMutableDictionary = NSMutableDictionary()
            peripheralData.setObject("iBeacon Demo", forKey: CBAdvertisementDataLocalNameKey)
            peripheralData.setObject(serviceUUIDs, forKey: CBAdvertisementDataServiceUUIDsKey)
            peripheralData.addEntriesFromDictionary(beaconData)
            
            self.peripheralManager!.startAdvertising(peripheralData)
        }
    }
    
    // MARK: CBPeripheralManager Delegate
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!)
    {
        let state: CBPeripheralManagerState = peripheralManager!.state
        
        if state == .PoweredOff {
            self.statusLabel.text = "Bluetooth Off"
            
            if self.broadcasting {
                self.broadcastBeacon(self.triggerButton)
            }
        }
        
        if state == .Unsupported {
            self.statusLabel.text = "Unsupported Beacon"
        }
        
        if state == .PoweredOn {
            self.statusLabel.text = "Not Broadcast"
        }
    }
}
