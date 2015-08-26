//
//  AppDelegate.swift
//  WatchConnectivity Introduction
//
//  Created by Davis Allie on 25/08/2015.
//  Copyright © 2015 tutsplus. All rights reserved.
//

import UIKit
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {

    var window: UIWindow?
    var session: WCSession!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        session = WCSession.defaultSession()
        session.delegate = self

        if WCSession.isSupported() {
            session.activateSession()
        }
        
        print(session.outstandingUserInfoTransfers)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            print([userInfo] as AnyObject)
            if let items = NSUserDefaults.standardUserDefaults().objectForKey("items") as? [NSDictionary] {
                var newItems = items
                newItems.append(userInfo)
                NSUserDefaults.standardUserDefaults().setObject(newItems as? AnyObject, forKey: "items")
            } else {
                NSUserDefaults.standardUserDefaults().setObject([userInfo] as AnyObject, forKey: "items")
            }
        }
    }
}

