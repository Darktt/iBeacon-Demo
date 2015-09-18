//
//  ReceiverViewController.swift
//  iBeacon Demo
//
//  Created by Darktt on 15/01/31.
//  Copyright (c) 2015年 Darktt. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class ReceiverViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate
{
    @IBOutlet weak var tableView: UITableView!
    private weak var refreshControl: UIRefreshControl?
    
    private var beacons: [CLBeacon] = []
    private var location: CLLocationManager?
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.refreshControl!.beginRefreshing()
        self.refreshBeacons(self.refreshControl!)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewDidDisappear(animated)
        
        self.refreshControl!.endRefreshing()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.iOS7BlueColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.location = CLLocationManager()
        self.location!.delegate = self
        self.location!.requestAlwaysAuthorization()
        
        let attributes: [String: AnyObject] = [NSForegroundColorAttributeName: UIColor.iOS7BlueColor()]
        let attributedTitle: NSAttributedString = NSAttributedString(string: "Receiving Beacon", attributes: attributes)
        
        let refreshControl: UIRefreshControl = UIRefreshControl()
        refreshControl.attributedTitle = attributedTitle
        refreshControl.addTarget(self, action: Selector("refreshBeacons:"), forControlEvents: UIControlEvents.ValueChanged)
        
        self.refreshControl = refreshControl
        self.tableView.addSubview(refreshControl)
    }
    
    deinit
    {
        self.location = nil
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return .LightContent
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation
    {
        return .None
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
    
    @objc private func refreshBeacons(sender: UIRefreshControl) -> Void
    {
        // This uuid must same as broadcaster.
        let UUID: NSUUID = iBeaconConfiguration.UUID()
        
        let beaconRegion: CLBeaconRegion = CLBeaconRegion(proximityUUID: UUID, identifier: "tw.darktt.beaconDemo")
        
        self.location!.startMonitoringForRegion(beaconRegion)
    }
    
    //MARK: - Other Method
    
    private func notifiBluetoothOff()
    {
        let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        
        let alert: UIAlertController = UIAlertController(title: "Bluetooth OFF", message: "Please power on your Bluetooth!", preferredStyle: .Alert)
        alert.addAction(OKAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //MARK: - UITableView DataSource Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.beacons.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let CellIdentifier: String = "CellIdentifier"
        
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(CellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: CellIdentifier)
        }
        
        let row: Int = indexPath.row
        let beacon: CLBeacon = self.beacons[row]
        let detailText: String = "Major: " + "\(beacon.major)" + "\tMinor: " + "\(beacon.minor)"
        let beaconUUID: String = beacon.proximityUUID.UUIDString
        
        cell?.textLabel?.text = detailText
        cell?.detailTextLabel?.text = beaconUUID
        
        return cell!
    }
    
    //MARK: - UITableView Delegate Methods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    //MARK: - CLocationManager Delegate Methods
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        guard status == .AuthorizedAlways else {
            print("******** User not authorized !!!!")
            return
        }
    }
    
    func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion)
    {
        manager.requestStateForRegion(region)
    }
    
    func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion region: CLRegion)
    {
        if state == .Inside {
            manager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
            return
        }
        
        manager.stopRangingBeaconsInRegion(region as! CLBeaconRegion)
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion)
    {
        self.beacons = beacons 
        
        print("\(self.beacons.first)")
        
        manager.stopRangingBeaconsInRegion(region)
        self.refreshControl?.endRefreshing()
        
        self.tableView.reloadData()
    }
}
