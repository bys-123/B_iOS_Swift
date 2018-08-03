//
//  AppDelegate.swift
//  FlappyBird
//
//  Created by Nate Murray on 6/2/14.
//  Copyright (c) 2014 Fullstack.io. All rights reserved.
//

import UIKit
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
import AppCenterPush
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MSCrashesDelegate,MSPushDelegate{
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //MSMobileCenter.setLogUrl("https://in-staging-south-centralus.staging.avalanch.es");
        MSCrashes.setDelegate(self)
        MSPush.setDelegate(self)
        MSAppCenter.start("534a1d28-c172-47be-a745-bf7431fcc5fb", withServices:[
            MSAnalytics.self,
            MSCrashes.self,
            MSPush.self
            ])        // Override point for customization after application launch.
        MSAnalytics.trackEvent("launch");
        var customProperties = MSCustomProperties()
        customProperties.setString("green", forKey: "color")
        customProperties.setNumber(10, forKey: "score")
        MSAppCenter.setCustomProperties(customProperties)
        var installId = MSAppCenter.installId();
        let alert = UIAlertView(title: "send scucceed", message: String(describing: installId),delegate: self,cancelButtonTitle: "OK");
        alert.show();
        MSCrashes.setUserConfirmationHandler({ (errorReports: [MSErrorReport]) in
            
            // Your code to present your UI to the user, e.g. an UIAlertView.
            let alert=UIAlertController(title: "Sorry we crashed!", message: "Do you want to send a Crash Report?", preferredStyle: UIAlertControllerStyle.alert);
            alert.addAction(UIAlertAction(title: "Always send", style: UIAlertActionStyle.default, handler: { action in
                MSCrashes.notify(with: MSUserConfirmation.always)}))
            alert.addAction(UIAlertAction(title: "send", style: UIAlertActionStyle.default, handler: { action in
                MSCrashes.notify(with: MSUserConfirmation.send)}))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { action in
                MSCrashes.notify(with: MSUserConfirmation.dontSend)}))
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            return true // Return true if the SDK should await user confirmation, otherwise return false.
        })
        return true
    }
    func crashes(_ crashes: MSCrashes!, didSucceedSending errorReport: MSErrorReport!) {
        let alert = UIAlertView(title: "send scucceed", message: "",delegate: self,cancelButtonTitle: "OK");
        alert.show();
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func attachments(with crashes: MSCrashes, for errorReport: MSErrorReport) -> [MSErrorAttachmentLog] {
        let attachment1 = MSErrorAttachmentLog.attachment(withText: "Hello world!", filename: "hello.txt")
        let attachment2 = MSErrorAttachmentLog.attachment(withBinary: "Fake image".data(using: String.Encoding.utf8), filename: nil, contentType: "image/jpeg")
        return [attachment1!, attachment2!]
    }
    func push(_ push: MSPush!, didReceive pushNotification: MSPushNotification!) {
        var message: String = pushNotification.message
        for item in pushNotification.customData {
            message = String(format: "%@\n%@: %@", message, item.key, item.value)
        }
        let alert = UIAlertView(title: pushNotification.title, message: message, delegate: self, cancelButtonTitle: "OK")
        alert.show()
    }
}

