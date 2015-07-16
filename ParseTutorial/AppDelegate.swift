//
//  AppDelegate.swift
//  ParseTutorial
//
//  Created by Austin Murtha on 4/14/15.
//  Copyright (c) 2015 AustinMurtha. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        UINavigationBar.appearance().barTintColor = UIColor.orangeColor()
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()  
            // Initialize Parse.
            Parse.setApplicationId("cWq6pTL1XAZ1sI4QgCAEk6uXxyaOJcaBak0issR4",
                clientKey: "f4f64W2b10yaKYdKuRm78U2FEggQ2Rhv2i2OBTbI")
        
        let notificationTypes = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
        let notificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)

        return true
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let currentInstallation = PFInstallation.currentInstallation()
        currentInstallation.setDeviceTokenFromData(deviceToken)
        currentInstallation.saveInBackgroundWithBlock({ (succeeded: Bool, error: NSError?) -> Void in
            
        })
    
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        println(error.localizedDescription)
    }
    
//    func application(application: UIApplication, didReceiveRemoteNotification userInfo:NSDictionary!) {
//        var notification = userInfo.objectForKey("aps")
//        
//        PFPush.handlePush(userInfo)
//    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
        var notification = userInfo["aps"] as! NSDictionary
        
        if (notification.objectForKey("content-avaialable") != nil){
            if notification.objectForKey("content-avaialable")!.isEqualToNumber(1){
                NSNotificationCenter.defaultCenter().postNotificationName("reloadTimeline", object: nil)
            }
            
        }else{
            PFPush.handlePush(userInfo)
        }
        
        PFPush.handlePush(userInfo)
        
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


}

