//
//  AppDelegate.swift
//  ProTip
//
//  Created by Ben Ashman on 10/8/15.
//  Copyright © 2015 Ben Ashman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var shortcutItem: UIApplicationShortcutItem?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        var performShortcutDelegate = true
        
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            print("application launched via. shortcut")
            self.shortcutItem = shortcutItem
            
            performShortcutDelegate = false
        }
        
        return performShortcutDelegate
    }
    
    // MARK: Quick Actions
    
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        completionHandler(handleQuickAction(shortcutItem))
    }
    
    func handleQuickAction(shortcutItem: UIApplicationShortcutItem) -> Bool {
        print("handling shortcut!")
        
        var succeeded = false
        
        switch shortcutItem.type {
        case "split-2":
            print("splitting bill 2 ways")
            succeeded = true
        case "split-3":
            print("splitting bill 3 ways")
            succeeded = true
        case "split-4":
            print("splitting bill 4 ways")
            succeeded = true
        default:
            succeeded = false
        }
        
        return succeeded
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
        print("application did become active!")
        
        guard let shortcut = shortcutItem else { return }
        
        print("shortcut property has been set")
        
        handleQuickAction(shortcut)
        
        self.shortcutItem = nil
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

