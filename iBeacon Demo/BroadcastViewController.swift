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

class BroadcastViewController: UIViewController, CBPeripheralManagerDelegate
{
    private var broadcasting: Bool = false
    
    private var beacon: CLBeaconRegion?
    private var peripheralManager: CBPeripheralManager?
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var triggerButton: UIButton!
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.iOS7WhiteColor()
        
        let UUID: NSUUID = iBeaconConfiguration.UUID()
        
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
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        if self.broadcasting {
            return .LightContent
        }
        
        return .Default
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation
    {
        return .Fade
    }
    
    override func prefersStatusBarHidden() -> Bool
    {
        return false
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Actions
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
            
            return title + " Broadcast"
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
            
            self.broadcasting = !self.broadcasting
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
        let completion: (Bool) -> Void = {
            finish in
            self.advertising(start: self.broadcasting)
        }
        
        UIView.animateWithDuration(0.25, animations: animations, completion: completion)
    }
    
    // MARK: - Broadcast Beacon
    func advertising(start start: Bool) -> Void
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
            let serviceUUIDs: Array<CBUUID> = [CBUUID(NSUUID: UUID)]
            
            let peripheralData: NSMutableDictionary = self.beacon!.peripheralDataWithMeasuredPower(1)
            peripheralData.setObject("iBeacon Demo", forKey: CBAdvertisementDataLocalNameKey)
            peripheralData.setObject(serviceUUIDs, forKey: CBAdvertisementDataServiceUUIDsKey)
            
            // Why NSMutableDictionary can not convert to Dictionary<String, AnyObject> 😂
            let _peripheralData: Dictionary<String, AnyObject> = peripheralData as NSDictionary as! Dictionary<String, AnyObject>
            
            self.peripheralManager!.startAdvertising(_peripheralData)
        }
    }
    
    // MARK: - CBPeripheralManager Delegate
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager)
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
