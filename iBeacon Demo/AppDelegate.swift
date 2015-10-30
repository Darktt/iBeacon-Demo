//
//  AppDelegate.swift
//  iBeacon Demo
//
//  Created by Darktt on 15/01/31.
//  Copyright (c) 2015年 Darktt. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate
{

    var window: UIWindow?
    private let locationManager: CLLocationManager = CLLocationManager()

    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool
    {
        let UUID: NSUUID = iBeaconConfiguration.UUID()
        
        let beaconRegion: CLBeaconRegion = CLBeaconRegion(proximityUUID: UUID, identifier: "tw.darktt.beaconDemo")
        beaconRegion.notifyEntryStateOnDisplay = true
        
        self.locationManager.delegate = self
        self.locationManager.startMonitoringForRegion(beaconRegion)
        
        return true
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        // Override point for customization after application launch.
        application.setStatusBarHidden(false, withAnimation: .None)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication)
    {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        NSLog("%@", __FUNCTION__)
    }

    func applicationDidEnterBackground(application: UIApplication)
    {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        NSLog("%@", __FUNCTION__)
        
        if let rootViewController: UITabBarController = self.window?.rootViewController as? UITabBarController {
            let selectedViewController: UIViewController = rootViewController.selectedViewController!
            selectedViewController.view.snapshotViewAfterScreenUpdates(true)
        }
    }

    func applicationWillEnterForeground(application: UIApplication)
    {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        NSLog("%@", __FUNCTION__)
    }

    func applicationDidBecomeActive(application: UIApplication)
    {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        NSLog("%@", __FUNCTION__)
    }

    func applicationWillTerminate(application: UIApplication)
    {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        NSLog("%@", __FUNCTION__)
    }
    
    func application(application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        NSLog("%@", __FUNCTION__)
        
        print("\(userActivityType)")
        
        return true
    }
    
    //MARK: - CLocationManager Delegate Methods
    
    func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion region: CLRegion)
    {
        if state == .Inside {
            print("locationManager didDetermineState INSIDE")
            
            let applicationState: UIApplicationState = UIApplication.sharedApplication().applicationState
            
            guard applicationState == .Active else {
                let tabBarController: UITabBarController = self.window?.rootViewController as! UITabBarController
                tabBarController.selectedIndex = 1
                return
            }
        }
        
        if state == .Outside {
            print("locationManager didDetermineState OUTSIDE")
        }
        
        if state == .Unknown {
            print("locationManager didDetermineState UNKNOWN")
        }
    }
}

