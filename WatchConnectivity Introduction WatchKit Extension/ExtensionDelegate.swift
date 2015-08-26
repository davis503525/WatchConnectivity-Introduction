//
//  ExtensionDelegate.swift
//  WatchConnectivity Introduction WatchKit Extension
//
//  Created by Davis Allie on 25/08/2015.
//  Copyright © 2015 tutsplus. All rights reserved.
//

import WatchKit
import WatchConnectivity

class ExtensionDelegate: NSObject, WKExtensionDelegate, WCSessionDelegate {
    
    var session: WCSession!

    func applicationDidFinishLaunching() {
        session = WCSession.defaultSession()
        session.delegate = self
        session.activateSession()
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }
    
    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if let items = NSUserDefaults.standardUserDefaults().objectForKey("items") as? [NSDictionary] {
                var newItems = items
                newItems.append(userInfo)
                NSUserDefaults.standardUserDefaults().setObject(newItems as AnyObject, forKey: "items")
            } else {
                NSUserDefaults.standardUserDefaults().setObject([userInfo] as AnyObject, forKey: "items")
            }
        }
    }
}
