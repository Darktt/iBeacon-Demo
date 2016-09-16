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
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool 
    {
        let UUID: UUID = iBeaconConfiguration.uuid
        
        let beaconRegion: CLBeaconRegion = CLBeaconRegion(proximityUUID: UUID, identifier: "tw.darktt.beaconDemo")
        beaconRegion.notifyEntryStateOnDisplay = true
        
        self.locationManager.delegate = self
        self.locationManager.startMonitoring(for: beaconRegion)
        
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool 
    {
        // Override point for customization after application launch.
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication)
    {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        print("\(#function)")
    }

    func applicationDidEnterBackground(_ application: UIApplication)
    {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("\(#function)")
        
        guard let window = self.window else {
            return
        }
        
        if let rootViewController: UITabBarController = window.rootViewController as? UITabBarController {
            let selectedViewController: UIViewController = rootViewController.selectedViewController!
            selectedViewController.view.snapshotView(afterScreenUpdates: true)
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication)
    {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        print("\(#function)")
    }

    func applicationDidBecomeActive(_ application: UIApplication)
    {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("\(#function)")
    }

    func applicationWillTerminate(_ application: UIApplication)
    {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("\(#function)")
    }
    
    func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool
    {
        print("\(#function)")
        
        print("\(userActivityType)")
        
        return true
    }
    
    //MARK: - CLocationManager Delegate Methods
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion)
    {
        if state == .inside {
            print("locationManager didDetermineState INSIDE")
            
            let applicationState: UIApplicationState = UIApplication.shared.applicationState
            
            guard applicationState == .active else {
                let tabBarController: UITabBarController = self.window?.rootViewController as! UITabBarController
                tabBarController.selectedIndex = 1
                return
            }
        }
        
        if state == .outside {
            print("locationManager didDetermineState OUTSIDE")
        }
        
        if state == .unknown {
            print("locationManager didDetermineState UNKNOWN")
        }
    }
}

