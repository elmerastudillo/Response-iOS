//
//  AppDelegate.swift
//  Response
//
//  Created by Keivan Shahida on 7/15/17.
//  Copyright © 2017 Keivan Shahida. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import Firebase
import RevealingSplashView
import IQKeyboardManagerSwift
import Stripe

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Fabric.with([Crashlytics.self])
        STPPaymentConfiguration.shared().publishableKey = "pk_test_NKN42L35p90iLG8Tnv9vMRdk"
        
        UINavigationBar.appearance().barTintColor = UIColor.responseBlack
        UINavigationBar.appearance().isTranslucent = false
        UIApplication.shared.statusBarStyle = .lightContent
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = TabBarController()
        
        UITabBar.appearance().tintColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)

        IQKeyboardManager.shared.enable = true
        
        let revealingSplashView = RevealingSplashView(iconImage: #imageLiteral(resourceName: "SplashIcon"),iconInitialSize: CGSize(width: 65, height: 63), backgroundColor: .responseBlack)
        window?.addSubview(revealingSplashView)
        revealingSplashView.duration = 0.9
        revealingSplashView.animationType = SplashAnimationType.squeezeAndZoomOut
        revealingSplashView.startAnimation(){ }
        
        let defaults = UserDefaults.standard
        let onboardComplete = defaults.bool(forKey: "OnboardComplete")
        
        if !onboardComplete {
            let destination = OnboardPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
            destination.modalPresentationStyle = .overCurrentContext
            window?.rootViewController?.present(destination, animated: false, completion: nil)
        }
        return true
    }
}
