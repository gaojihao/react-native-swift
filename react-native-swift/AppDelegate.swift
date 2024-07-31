//
//  AppDelegate.swift
//  react-native-swift
//
//  Created by Saiki on 2023/5/15.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow? = nil

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let tabBarController = LZTabBarController()
        let rootVC = LZNavigationController(rootViewController: tabBarController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        return true
    }
}

