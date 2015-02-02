//
//  ReceiverViewController.swift
//  iBeacon Tester
//
//  Created by EdenLi on 2015/1/31.
//  Copyright (c) 2015年 Darktt. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class ReceiverViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate
{
    @IBOutlet weak var tableView: UITableView!
    weak var refreshControl: UIRefreshControl?
    
    private var beacons: [CLBeacon] = []
    private var location: CLLocationManager?
    
    override func viewWillAppear(animated: Bool)
    {
        self.setNeedsStatusBarAppearanceUpdate()
        self.refreshControl!.beginRefreshing()
        self.refreshBeacons(self.refreshControl!)
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        self.refreshControl!.endRefreshing()
    }
    
    override func viewDidLoad()
    {
        self.navigationController?.navigationBar.barTintColor = UIColor.iOS7BlueColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.location = CLLocationManager()
        self.location?.delegate = self
        self.location?.requestAlwaysAuthorization()
        
        let attributes: [String: AnyObject] = [NSForegroundColorAttributeName: UIColor.iOS7BlueColor()]
        let attributedTitle: NSAttributedString = NSAttributedString(string: "Receiving Beacon", attributes: attributes)
        
        let refreshControl: UIRefreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshBeacons:", forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.attributedTitle = attributedTitle
        
        self.refreshControl = refreshControl
        self.tableView.addSubview(refreshControl)
    }
    
    deinit
    {
        self.location = nil
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .BlackOpaque
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
        let UUID: NSUUID = NSUUID(UUIDString: "7FA08BC7-A55F-45FC-85C0-0BF26F899530")!
        
        let beaconRegion: CLBeaconRegion = CLBeaconRegion(proximityUUID: UUID, identifier: "tw.darktt.beaconDemo")
        
        self.location!.startMonitoringForRegion(beaconRegion)
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
        
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as UITableViewCell?
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
    
    func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion!)
    {
        manager.requestStateForRegion(region)
    }
    
    func locationManager(manager: CLLocationManager!, didDetermineState state: CLRegionState, forRegion region: CLRegion!)
    {
        if state == .Inside {
            manager.startRangingBeaconsInRegion(region as CLBeaconRegion)
            
            return
        }
        
        manager.stopRangingBeaconsInRegion(region as CLBeaconRegion)
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!)
    {
        manager.startRangingBeaconsInRegion(region as CLBeaconRegion)
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!)
    {
        manager.stopRangingBeaconsInRegion(region as CLBeaconRegion)
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!)
    {
        self.beacons = beacons as [CLBeacon]
        
        manager.stopRangingBeaconsInRegion(region)
        self.refreshControl?.endRefreshing()
        
        self.tableView.reloadData()
    }
}
