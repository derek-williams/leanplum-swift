//
//  AppDelegate.swift
//  TicTacToeApp
//
//  Created by Derek Williams on 1/29/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import UIKit
#if DEBUG
    import AdSupport
#endif
import Leanplum

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool {
        // We've inserted your Test API keys here for you :)
        #if DEBUG
            Leanplum.setDeviceId(ASIdentifierManager.shared().advertisingIdentifier.uuidString)
            Leanplum.setAppId("app_H91bpadV0q6DpBHmH9cshCdJsxVU3LQsQhBQTPAKAYk",
                              withDevelopmentKey:"dev_DTkh2KbUEJdTxUGUTq1MsVhYnv9xzWs4jHK9etDNHFg")
        #else
            Leanplum.setAppId("app_H91bpadV0q6DpBHmH9cshCdJsxVU3LQsQhBQTPAKAYk",
                              withProductionKey: "prod_dC9VMUkMResITEboR4Y5iuHVOYn5s50UuQhi6Pgwgqo")
        #endif
        
        // Optional: Tracks in-app purchases automatically as the "Purchase" event.
        // To require valid receipts upon purchase or change your reported
        // currency code from USD, update your app settings.
         Leanplum.trackInAppPurchases()
        
        // Optional: Tracks all screens in your app as states in Leanplum.
         Leanplum.trackAllAppScreens()
        
        // Optional: Activates UI Editor.
        // Requires the Leanplum-iOS-UIEditor framework.
        // LeanplumUIEditor.shared().allowInterfaceEditing()
        
        // Starts a new session and updates the app content from Leanplum.
        Leanplum.start(userAttributes: ["gender":"Male", "age": 24])
        
        return true
    }
}
