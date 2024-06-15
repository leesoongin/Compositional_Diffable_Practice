//
//  AppDelegate.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/10/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UICollectionReusableView.swizzlePrepareForReuse()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        self.window?.rootViewController = HomeViewController()
        
        window.makeKeyAndVisible()
        
        return true
    }

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        return true
    }
}
